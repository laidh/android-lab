import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:volunteer/models/users/user.dart';
import 'package:volunteer/models/users/eula.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:volunteer/models/user_role.dart';
import 'package:volunteer/providers/main_provider.dart';
import 'package:volunteer/screens/home/home_screen.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final CollectionReference<User> usersCollection = FirebaseFirestore.instance
      .collection('users')
      .withConverter<User>(
          fromFirestore: (snapshot, _) => User.fromJson(snapshot.data()!),
          toFirestore: (task, _) => task.toJson());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  var _isLoading = false;
  var _acceptedTermsAndConditionsAndPrivacyPolicy = false;
  UserRole? _role;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: firebase.FirebaseAuth.instance.currentUser != null
            ? Text(
                'Завершення реєстрації',
                style: TextStyle(
                    color: Colors.pink,
                    fontSize: 14.0,
                    fontWeight: FontWeight.normal),
              )
            : Container(),
        iconTheme: IconThemeData(
          color: Colors.pink,
        ),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(left: 32.0, right: 32.0),
          child: Column(
            children: [
              Image.asset('assets/images/logo.png'),
              SizedBox(
                height: 32.0,
              ),
              _buildRegistrationForm(context),
              SizedBox(
                height: 32.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Checkbox(
                        value: _acceptedTermsAndConditionsAndPrivacyPolicy,
                        onChanged: (value) {
                          setState(() {
                            _acceptedTermsAndConditionsAndPrivacyPolicy =
                                value ?? false;
                          });
                        }),
                  ),
                  Expanded(
                    flex: 7,
                    child: RichText(
                        text: TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: 'Я погоджуюсь з ',
                          style: TextStyle(
                              color: Colors.blueGrey, fontSize: 14.0)),
                      TextSpan(
                          text: 'Умовами та Положеннями',
                          style: TextStyle(color: Colors.blue, fontSize: 14.0),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              var termsAndConditionsUrl =
                                  'https://www.google.com/search?q=terms+and+conditions';
                              await canLaunch(termsAndConditionsUrl)
                                  ? await launch(termsAndConditionsUrl)
                                  : throw 'Could not launch $termsAndConditionsUrl';
                            }),
                      TextSpan(
                          text: ' та ',
                          style: TextStyle(
                              color: Colors.blueGrey, fontSize: 14.0)),
                      TextSpan(
                          text: 'Політикою Конфіденційності',
                          style: TextStyle(color: Colors.blue, fontSize: 14.0),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              var privacyPolicyUrl =
                                  'https://www.google.com/search?q=privacy+policy';
                              await canLaunch(privacyPolicyUrl)
                                  ? await launch(privacyPolicyUrl)
                                  : throw 'Could not launch $privacyPolicyUrl';
                            }),
                    ])),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRegistrationForm(BuildContext context) {
    final currentUser = firebase.FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      emailController.text = currentUser.email!;
    }

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: firstNameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Введіть ім'я";
              }
              return null;
            },
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: "Ім'я",
            ),
            keyboardType: TextInputType.name,
          ),
          TextFormField(
            controller: lastNameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Введіть прізвище";
              }
              return null;
            },
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: "Прізвище",
            ),
            keyboardType: TextInputType.name,
          ),
          TextFormField(
            enabled: currentUser == null,
            controller: emailController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Введіть електронну скриньку';
              }
              return null;
            },
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Електронна скринька',
            ),
            keyboardType: TextInputType.emailAddress,
            autocorrect: false,
          ),
          if (currentUser == null)
            TextFormField(
              controller: passwordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Введіть пароль';
                }
                return null;
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 8),
                border: UnderlineInputBorder(),
                labelText: 'Пароль',
              ),
              obscureText: true,
              autocorrect: false,
            ),
          DropdownButtonFormField<UserRole>(
              validator: (value) {
                if (_role == null) {
                  return 'Виберіть роль';
                }
                return null;
              },
              hint: Text('Виберіть роль'),
              isExpanded: true,
              onChanged: (value) {
                setState(() {
                  _role = value ?? UserRole.VOLUNTEER;
                });
              },
              items: UserRole.values
                  .where((e) => e != UserRole.SUPER_ADMIN)
                  .map((e) => DropdownMenuItem(
                      value: e,
                      child: FittedBox(
                        child: Text(
                          e.valueUkrainian(),
                        ),
                      )))
                  .toList()),
          SizedBox(
            height: 16.0,
          ),
          Container(
            height: 48,
            width: MediaQuery.of(context).size.width / 2,
            child: ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  if (!_acceptedTermsAndConditionsAndPrivacyPolicy) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          'Підтвердіть, що ви погоджуєтесь з Умовами та Положенням та Політикою Конфіденційності.'),
                      backgroundColor: Colors.red.shade900,
                    ));

                    return;
                  }

                  setState(() {
                    _isLoading = true;
                  });

                  currentUser == null
                      ? _register(context)
                      : _finishRegistration(context);
                }
              },
              child: _isLoading
                  ? SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                        strokeWidth: 2.0,
                      ))
                  : Text(
                      'Зареєструватись',
                      style: TextStyle(fontSize: 16.0),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  void _register(BuildContext context) async {
    try {
      var userCredential = await firebase.FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);

      if (userCredential.user != null && !userCredential.user!.emailVerified) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                'Лист на підтвердження був надісланий на вашу електронну скриньку.')));

        await userCredential.user!.sendEmailVerification();
      }

      var userReference = usersCollection.doc(userCredential.user!.uid);

      // Get the token each time the application loads (contains web push token for web)
      String? token = await FirebaseMessaging.instance.getToken(
          vapidKey:
              "BKcGNRbR4wP2zA9_XRx_hdeCUbETB_yvhmQg2FStwRvAPPutwJvwu-pqQxsLFw4u9KficFIm8zdOho2A3lBLGjI");

      var eula =
          Eula(DateTime.now(), _acceptedTermsAndConditionsAndPrivacyPolicy);
      var user = User(
          userReference.id,
          emailController.text,
          firstNameController.text,
          lastNameController.text,
          null,
          null,
          null,
          _role!,
          [token],
          eula);

      // create user if not found
      await userReference.set(user, SetOptions(merge: true));
      context.read<MainProvider>().userReference = userReference;

      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => HomeScreen()), (_) => false);
    } on firebase.FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Пароль занадто слабкий.'),
          backgroundColor: Colors.red.shade900,
        ));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Користувач з такою електронною скринькою вже існує.'),
          backgroundColor: Colors.red.shade900,
        ));
      } else if (e.code == 'invalid-email') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Некоректна електронна скринька.'),
          backgroundColor: Colors.red.shade900,
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.red.shade900,
      ));
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _finishRegistration(BuildContext context) async {
    try {
      var userReference =
          usersCollection.doc(firebase.FirebaseAuth.instance.currentUser!.uid);

      // Get the token each time the application loads (contains web push token for web)
      String? token = await FirebaseMessaging.instance.getToken(
          vapidKey:
              "BKcGNRbR4wP2zA9_XRx_hdeCUbETB_yvhmQg2FStwRvAPPutwJvwu-pqQxsLFw4u9KficFIm8zdOho2A3lBLGjI");

      var eula =
          Eula(DateTime.now(), _acceptedTermsAndConditionsAndPrivacyPolicy);
      var user = User(
          userReference.id,
          emailController.text,
          firstNameController.text,
          lastNameController.text,
          null,
          null,
          null,
          _role!,
          [token],
          eula);

      // create user if not found
      await userReference.set(user, SetOptions(merge: true));

      context.read<MainProvider>().userReference = userReference;

      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => HomeScreen()), (_) => false);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.red.shade900,
      ));
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
