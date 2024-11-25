// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['id'] as String,
    json['email'] as String,
    json['firstName'] as String,
    json['lastName'] as String,
    json['photoUrl'] as String?,
    json['about'] as String?,
    (json['socials'] as List<dynamic>?)
        ?.map((e) => SocialMedia.fromJson(e as Map<String, dynamic>))
        .toList(),
    _$enumDecode(_$UserRoleEnumMap, json['role']),
    (json['tokens'] as List<dynamic>).map((e) => e as String?).toList(),
    Eula.fromJson(json['eula'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'photoUrl': instance.photoUrl,
      'about': instance.about,
      'socials': instance.socials?.map((e) => e.toJson()).toList(),
      'tokens': instance.tokens,
      'role': _$UserRoleEnumMap[instance.role],
      'eula': instance.eula.toJson(),
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

const _$UserRoleEnumMap = {
  UserRole.VOLUNTEER: 'VOLUNTEER',
  UserRole.ADMIN: 'ADMIN',
  UserRole.REGION_ADMIN: 'REGION_ADMIN',
  UserRole.SUPER_ADMIN: 'SUPER_ADMIN',
};
