// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) {
  return Question(
    json['title'] as String?,
    _$enumDecode(_$QuestionTypeEnumMap, json['type']),
    description: json['description'],
    isRequired: json['isRequired'],
  );
}

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'type': _$QuestionTypeEnumMap[instance.type],
      'isRequired': instance.isRequired,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$QuestionTypeEnumMap = {
  QuestionType.SHORT_TEXT: 'SHORT_TEXT',
  QuestionType.LONG_TEXT: 'LONG_TEXT',
  QuestionType.MULTIPLE: 'MULTIPLE',
  QuestionType.SINGLE: 'SINGLE',
};
