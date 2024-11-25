import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:volunteer/models/polls/questions/question.dart';

part 'poll.g.dart';

@JsonSerializable(explicitToJson: true)
class Poll {
  String id;
  String? title;
  String? description;
  DateTime? startDate;
  DateTime? endDate;
  List<Question>? questions;

  /// User document references
  List<String>? users;

  Poll(
      {this.title,
      this.description,
      this.startDate,
      this.endDate,
      this.questions,
      this.users})
      : id = Uuid().v4();

  factory Poll.fromJson(Map<String, dynamic> json) => _$PollFromJson(json);
  Map<String, dynamic> toJson() => _$PollToJson(this);
}
