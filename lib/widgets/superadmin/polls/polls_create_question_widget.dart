import 'package:flutter/material.dart';
import 'package:volunteer/models/polls/questions/long_text_question.dart';
import 'package:volunteer/models/polls/questions/multiple_question.dart';
import 'package:volunteer/models/polls/questions/question.dart';
import 'package:volunteer/models/polls/questions/question_type.dart';
import 'package:volunteer/models/polls/questions/short_text_question.dart';
import 'package:volunteer/models/polls/questions/single_question.dart';

class CreateQuestionWidget extends StatefulWidget {
  @override
  _CreateQuestionWidgetState createState() => _CreateQuestionWidgetState();
}

class _CreateQuestionWidgetState extends State<CreateQuestionWidget> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  // By default short answer question is used
  QuestionType _questionType = QuestionType.SHORT_TEXT;

  List<Widget> _answerWidgets = [];
  List<TextEditingController> _answerControllers = [];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Нове запитання'),
      content: Scrollbar(
        child: SingleChildScrollView(
          child: IntrinsicHeight(
            child: Form(
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
                    decoration: const InputDecoration(labelText: 'Опис'),
                  ),
                  SizedBox(height: 24.0),
                  DropdownButton<QuestionType>(
                      value: _questionType,
                      isExpanded: true,
                      items: QuestionType.values
                          .map((e) => DropdownMenuItem(
                              value: e,
                              child: FittedBox(
                                child: Text(
                                  e.valueUkrainian(),
                                ),
                              )))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _questionType = value ?? QuestionType.SHORT_TEXT;
                        });
                      }),
                  ..._answerWidgets.map((widget) {
                    return Column(children: [SizedBox(height: 16.0), widget]);
                  }).toList(),
                  _buildAddAnswerWidget()
                ],
              ),
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          child: Text('Відмінити', style: TextStyle(color: Colors.blueGrey)),
          onPressed: () {
            Navigator.pop(context, null);
          },
        ),
        TextButton(
          child: Text('Застосувати'),
          onPressed: () {
            if (!_formKey.currentState!.validate()) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Перевірте правильність введених полей'),
                backgroundColor: Colors.red.shade900,
              ));
              return;
            }

            var variants = _answerControllers
                .map((controller) => controller.text)
                .toList();

            Question question;
            switch (_questionType) {
              case QuestionType.SHORT_TEXT:
                question = ShortTextQuestion(
                    _titleController.text, _descriptionController.text);
                break;
              case QuestionType.LONG_TEXT:
                question = LongTextQuestion(
                    _titleController.text, _descriptionController.text);
                break;
              case QuestionType.SINGLE:
              case QuestionType.MULTIPLE:
                if (variants.length < 2) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Добавте мінімум 2 варіанти відповідей'),
                    backgroundColor: Colors.red.shade900,
                  ));
                  return;
                }

                if (_questionType == QuestionType.SINGLE) {
                  question = SingleQuestion(_titleController.text,
                      _descriptionController.text, variants);
                } else {
                  question = MultipleQuestion(_titleController.text,
                      _descriptionController.text, variants);
                }

                break;
            }

            Navigator.pop(context, question);
          },
        )
      ],
    );
  }

  Widget _buildAddAnswerWidget() {
    if (_questionType == QuestionType.MULTIPLE ||
        _questionType == QuestionType.SINGLE) {
      return Column(
        children: [
          SizedBox(height: 32.0),
          FloatingActionButton.extended(
            onPressed: () {
              Widget answerWidget;
              TextEditingController answerController = TextEditingController();
              final number = _answerWidgets.length + 1;

              answerWidget = Row(
                children: [
                  SizedBox(
                      width: 24.0,
                      height: 24.0,
                      child: _questionType == QuestionType.SINGLE
                          ? Radio(
                              value: false, groupValue: true, onChanged: null)
                          : Checkbox(value: false, onChanged: null)),
                  SizedBox(width: 12.0),
                  Expanded(
                      child: TextFormField(
                    controller: answerController,
                    decoration:
                        InputDecoration(labelText: 'Відповідь #$number'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Введіть відповідь';
                      }

                      return null;
                    },
                  ))
                ],
              );
              setState(() {
                _answerControllers.add(answerController);
                _answerWidgets.add(answerWidget);
              });
            },
            label: Text('Добавити відповідь'),
            icon: Icon(Icons.add),
          ),
          SizedBox(height: 16.0),
        ],
      );
    } else {
      return Container();
    }
  }
}
