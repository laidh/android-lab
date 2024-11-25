import 'package:volunteer/models/users/user.dart';

/// Represents user review about anything
class Review {
  /// Author of the review
  final User user;

  /// Message of the review
  final String comment;

  /// Rating provided with the review
  final int rating;

  Review(this.user, this.comment, this.rating);
}
