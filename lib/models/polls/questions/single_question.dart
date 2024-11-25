import 'package:json_annotation/json_annotation.dart';
import 'package:volunteer/models/polls/questions/question.dart';
import 'package:volunteer/models/polls/questions/question_type.dart';

part 'single_question.g.dart';

/// Question with the single variant of answer (radio buttons)
@JsonSerializable()
class SingleQuestion extends Question {
  List<String> variants;

  SingleQuestion(title, description, this.variants)
      : super(title, QuestionType.SINGLE, description: description);

  factory SingleQuestion.fromJson(Map<String, dynamic> json) =>
      _$SingleQuestionFromJson(json);
  Map<String, dynamic> toJson() => _$SingleQuestionToJson(this);
}
