import 'package:json_annotation/json_annotation.dart';
import 'package:volunteer/models/social_media_type.dart';

part 'social_media.g.dart';

/// Represents social media
@JsonSerializable()
class SocialMedia {
  final SocialMediaType type;
  final String url;

  SocialMedia(this.type, this.url);

  factory SocialMedia.fromJson(Map<String, dynamic> json) =>
      _$SocialMediaFromJson(json);
  Map<String, dynamic> toJson() => _$SocialMediaToJson(this);
}
