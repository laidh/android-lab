import 'package:json_annotation/json_annotation.dart';
import 'package:volunteer/models/social_media.dart';
import 'package:volunteer/models/user_role.dart';
import 'package:volunteer/models/users/eula.dart';

part 'user.g.dart';

/// Represents the user of the application
@JsonSerializable(explicitToJson: true)
class User {
  final String id;
  final String email;
  final String firstName;
  final String lastName;

  /// Avatar url
  final String? photoUrl;

  /// User description and about info
  final String? about;

  /// User social media references
  final List<SocialMedia>? socials;

  /// User FCM tokens
  final List<String?> tokens;

  /// Role of the user
  final UserRole role;

  /// Object containing information about user and EULA
  final Eula eula;

  User(this.id, this.email, this.firstName, this.lastName, this.photoUrl,
      this.about, this.socials, this.role, this.tokens, this.eula);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
