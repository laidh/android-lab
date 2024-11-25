import 'package:json_annotation/json_annotation.dart';
import 'package:volunteer/models/polls/questions/question_type.dart';

part 'question.g.dart';

@JsonSerializable()
class Question {
  String? title;
  String description;
  QuestionType type;
  bool isRequired;

  Question(this.title, this.type, {description, isRequired})
      : this.isRequired = isRequired ?? false,
        this.description = description ?? '';

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}
