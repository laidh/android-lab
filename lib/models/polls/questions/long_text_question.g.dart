// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'long_text_question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LongTextQuestion _$LongTextQuestionFromJson(Map<String, dynamic> json) {
  return LongTextQuestion(
    json['title'],
    json['description'],
  )
    ..type = _$enumDecode(_$QuestionTypeEnumMap, json['type'])
    ..isRequired = json['isRequired'] as bool;
}

Map<String, dynamic> _$LongTextQuestionToJson(LongTextQuestion instance) =>
    <String, dynamic>{
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
