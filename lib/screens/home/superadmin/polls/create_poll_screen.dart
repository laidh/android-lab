import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:volunteer/models/polls/poll.dart';
import 'package:volunteer/models/polls/questions/multiple_question.dart';
import 'package:volunteer/models/polls/questions/question.dart';
import 'package:volunteer/models/polls/questions/question_type.dart';
import 'package:volunteer/models/polls/questions/single_question.dart';
import 'package:volunteer/widgets/superadmin/polls/polls_create_question_widget.dart';

class CreatePollScreen extends StatefulWidget {
  @override
  _CreatePollScreenState createState() => _CreatePollScreenState();
}

class _CreatePollScreenState extends State<CreatePollScreen> {
  final CollectionReference<Poll> _pollsCollection = FirebaseFirestore.instance
      .collection('polls')
      .withConverter<Poll>(
          fromFirestore: (snapshot, _) => Poll.fromJson(snapshot.data()!),
          toFirestore: (task, _) => task.toJson());

  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  Poll _poll = Poll();

  @override
  void initState() {
    super.initState();

    _poll.questions = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Нове опитування'),
        actions: [
          IconButton(
              icon: Icon(CupertinoIcons.checkmark_alt),
              onPressed: () {
                if (!_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Перевірте правильність введених полей'),
                    backgroundColor: Colors.red.shade900,
                  ));
                  return;
                }

                if (_poll.questions!.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Добавте хоча б одне запитання'),
                    backgroundColor: Colors.red.shade900,
                  ));
                  return;
                }

                _poll.title = _titleController.text;
                _poll.description = _descriptionController.text;
                _poll.startDate = DateTime.now();
                _poll.endDate = _poll.startDate?.add(Duration(days: 7));
                _poll.users = [];

                _pollsCollection
                    .doc(_poll.id)
                    .set(_poll)
                    .then((_) => Navigator.pop(context));
              })
        ],
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _titleController,
                        decoration: const InputDecoration(labelText: 'Назва'),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Введіть назву опитування';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _descriptionController,
                        decoration: const InputDecoration(
                            labelText: "Опис (необов'язково)"),
                      ),
                      SizedBox(height: 32.0),
                      ..._buildQuestions(context),
                      SizedBox(height: 32.0),
                      FloatingActionButton.extended(
                        onPressed: () async {
                          Question? question = await showDialog<Question?>(
                              context: context,
                              builder: (context) {
                                return CreateQuestionWidget();
                              });

                          if (question != null) {
                            setState(() {
                              _poll.questions!.add(question);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                    "Запитання '${question.title}' добавлено"),
                              ));
                            });
                          }
                        },
                        label: Text('Добавити запитання'),
                        icon: Icon(Icons.add),
                      ),
                      SizedBox(height: 16.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the list of question widgets
  List<Widget> _buildQuestions(BuildContext context) {
    return _poll.questions!
        .asMap()
        .map((index, question) {
          if (question.type == QuestionType.SHORT_TEXT ||
              question.type == QuestionType.LONG_TEXT) {
            return MapEntry(
              index,
              ListTile(
                contentPadding: EdgeInsets.all(0.0),
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${index + 1}.'),
                  ],
                ),
                title: question.title == null ? null : Text(question.title!),
                subtitle: Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: question.description.isEmpty
                        ? Text(
                            "(${question.type.valueUkrainian()})",
                            style: TextStyle(color: Colors.grey),
                          )
                        : Text(
                            "${question.description} (${question.type.valueUkrainian()})",
                            style: TextStyle(color: Colors.grey),
                          )),
              ),
            );
          } else {
            final List<String> variants;
            if (question is SingleQuestion) {
              variants = question.variants;
            } else {
              variants = (question as MultipleQuestion).variants;
            }
            return MapEntry(
              index,
              ExpansionTile(
                  childrenPadding: EdgeInsets.symmetric(vertical: 8.0),
                  expandedAlignment: Alignment.centerLeft,
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  tilePadding: EdgeInsets.all(0.0),
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${index + 1}.'),
                    ],
                  ),
                  title: question.title == null
                      ? Container()
                      : Text(question.title!),
                  subtitle: Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: question.description.isEmpty
                          ? Text(
                              "(${question.type.valueUkrainian()})",
                              style: TextStyle(color: Colors.grey),
                            )
                          : Text(
                              "${question.description} (${question.type.valueUkrainian()})",
                              style: TextStyle(color: Colors.grey),
                            )),
                  children: [
                    ...variants
                        .asMap()
                        .map((index, variant) => MapEntry(
                            index,
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                "${index + 1}. $variant",
                                style: TextStyle(color: Colors.blueGrey),
                              ),
                            )))
                        .values
                        .toList(),
                  ]),
            );
          }
        })
        .values
        .toList();
  }
}
