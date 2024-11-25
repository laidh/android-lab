// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eula.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Eula _$EulaFromJson(Map<String, dynamic> json) {
  return Eula(
    DateTime.parse(json['timestamp'] as String),
    json['accepted'] as bool,
  );
}

Map<String, dynamic> _$EulaToJson(Eula instance) => <String, dynamic>{
      'timestamp': instance.timestamp.toIso8601String(),
      'accepted': instance.accepted,
    };
