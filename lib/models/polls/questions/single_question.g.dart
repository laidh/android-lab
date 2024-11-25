// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SingleQuestion _$SingleQuestionFromJson(Map<String, dynamic> json) {
  return SingleQuestion(
    json['title'],
    json['description'],
    (json['variants'] as List<dynamic>).map((e) => e as String).toList(),
  )
    ..type = _$enumDecode(_$QuestionTypeEnumMap, json['type'])
    ..isRequired = json['isRequired'] as bool;
}

Map<String, dynamic> _$SingleQuestionToJson(SingleQuestion instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'type': _$QuestionTypeEnumMap[instance.type],
      'isRequired': instance.isRequired,
      'variants': instance.variants,
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
