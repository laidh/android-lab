import 'package:json_annotation/json_annotation.dart';
import 'package:volunteer/models/polls/questions/question.dart';
import 'package:volunteer/models/polls/questions/question_type.dart';

part 'short_text_question.g.dart';

/// Question with the short text answer
@JsonSerializable()
class ShortTextQuestion extends Question {
  ShortTextQuestion(title, description)
      : super(title, QuestionType.SHORT_TEXT, description: description);

  factory ShortTextQuestion.fromJson(Map<String, dynamic> json) =>
      _$ShortTextQuestionFromJson(json);
  Map<String, dynamic> toJson() => _$ShortTextQuestionToJson(this);
}
