import 'package:json_annotation/json_annotation.dart';
import 'package:volunteer/models/polls/questions/question.dart';
import 'package:volunteer/models/polls/questions/question_type.dart';

part 'long_text_question.g.dart';

/// Question with the long text answer
@JsonSerializable()
class LongTextQuestion extends Question {
  LongTextQuestion(title, description)
      : super(title, QuestionType.LONG_TEXT, description: description);

  factory LongTextQuestion.fromJson(Map<String, dynamic> json) =>
      _$LongTextQuestionFromJson(json);
  Map<String, dynamic> toJson() => _$LongTextQuestionToJson(this);
}
