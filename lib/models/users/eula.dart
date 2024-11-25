import 'package:json_annotation/json_annotation.dart';

part 'eula.g.dart';

@JsonSerializable()
class Eula {
  final DateTime timestamp;
  final bool accepted;

  Eula(this.timestamp, this.accepted);

  factory Eula.fromJson(Map<String, dynamic> json) => _$EulaFromJson(json);
  Map<String, dynamic> toJson() => _$EulaToJson(this);
}
