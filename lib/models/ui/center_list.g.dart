// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'center_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CenterList _$CenterListFromJson(Map<String, dynamic> json) {
  return CenterList(
    json['id'] as String,
    json['title'] as String,
    json['adress'] as String,
    json['pathToImage'] as String,
  );
}

Map<String, dynamic> _$CenterListToJson(CenterList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'adress': instance.adress,
      'pathToImage': instance.pathToImage,
    };
