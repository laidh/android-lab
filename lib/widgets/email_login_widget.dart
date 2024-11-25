import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:volunteer/screens/login_screen.dart';
import 'package:volunteer/widgets/set_password_login_widget.dart';

class EmailLoginWidget extends StatefulWidget {
  final OnSignedIn? onSignedIn;
  final String email;

  EmailLoginWidget({email, this.onSignedIn}) : this.email = email ?? '';

  @override
  _EmailLoginWidgetState createState() => _EmailLoginWidgetState();
}

class _EmailLoginWidgetState extends State<EmailLoginWidget> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  var _isLoading = false;

  @override
  void initState() {
    super.initState();

    emailController.text = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
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
          SizedBox(
            height: 16.0,
          ),
          Container(
            height: 48,
            width: MediaQuery.of(context).size.width / 2,
            child: ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    _isLoading = true;
                  });
                  _login(context);
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
                      'Увійти',
                      style: TextStyle(fontSize: 16.0),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  void _login(BuildContext context) async {
    try {
      var userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);

      if (userCredential.user != null && !userCredential.user!.emailVerified) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text('Підтвердіть вашу електронну скриньку, щоб продовжити.'),
          action: SnackBarAction(
            label: 'Надіслати ще раз',
            onPressed: () async {
              await userCredential.user!.sendEmailVerification();
            },
          ),
        ));

        return;
      }

      widget.onSignedIn?.call(userCredential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Не знайдено користувача з електронною скринькою ${emailController.text}.'),
          backgroundColor: Colors.red.shade900,
        ));
      } else if (e.code == 'wrong-password') {
        // Fetch a list of what sign-in methods exist for the conflicting user
        List<String> userSignInMethods = await FirebaseAuth.instance
            .fetchSignInMethodsForEmail(emailController.text);

        // If user does not have account - show wrong password
        if (userSignInMethods.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Неправильний пароль.'),
            backgroundColor: Colors.red.shade900,
          ));

          return;
        }

        showModalBottomSheet(
            context: context,
            builder: (context) {
              return SetPasswordLoginWidget(
                  email: emailController.text,
                  password: passwordController.text,
                  userSignInMethods: userSignInMethods);
            });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
