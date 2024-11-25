import 'package:json_annotation/json_annotation.dart';
import 'package:volunteer/models/polls/questions/question.dart';
import 'package:volunteer/models/polls/questions/question_type.dart';

part 'multiple_question.g.dart';

/// Question with the multiple variants of answer (checkboxes)
@JsonSerializable()
class MultipleQuestion extends Question {
  List<String> variants;

  MultipleQuestion(title, description, this.variants)
      : super(title, QuestionType.MULTIPLE, description: description);

  factory MultipleQuestion.fromJson(Map<String, dynamic> json) =>
      _$MultipleQuestionFromJson(json);
  Map<String, dynamic> toJson() => _$MultipleQuestionToJson(this);
}
