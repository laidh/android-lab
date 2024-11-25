import 'package:json_annotation/json_annotation.dart';

part 'center_list.g.dart';
///Represents item from database for volunteerings_centers_list screen
@JsonSerializable()
class CenterList {
  final String id;
  final String title;
  final String adress;
  final String pathToImage;

  CenterList(this.id, this.title, this.adress, this.pathToImage);

  factory CenterList.fromJson(Map<String, dynamic> json) => _$CenterListFromJson(json);
  Map<String, dynamic> toJson() => _$CenterListToJson(this);
}
