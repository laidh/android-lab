// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_media.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SocialMedia _$SocialMediaFromJson(Map<String, dynamic> json) {
  return SocialMedia(
    _$enumDecode(_$SocialMediaTypeEnumMap, json['type']),
    json['url'] as String,
  );
}

Map<String, dynamic> _$SocialMediaToJson(SocialMedia instance) =>
    <String, dynamic>{
      'type': _$SocialMediaTypeEnumMap[instance.type],
      'url': instance.url,
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

const _$SocialMediaTypeEnumMap = {
  SocialMediaType.GOOGLE: 'GOOGLE',
  SocialMediaType.FACEBOOK: 'FACEBOOK',
  SocialMediaType.INSTAGRAM: 'INSTAGRAM',
  SocialMediaType.TELEGRAM: 'TELEGRAM',
  SocialMediaType.TIKTOK: 'TIKTOK',
  SocialMediaType.APPLE: 'APPLE',
};
