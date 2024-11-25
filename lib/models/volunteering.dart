import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:volunteer/models/users/user.dart';

/// Represents volunteering
class Volunteering {
  /// Title of volunteering
  final String title;

  /// Description of the volunteering.
  /// Contains value gained from it, required tools, achievements, plan
  /// and other information.
  final String description;

  /// Contact person of the volunteering
  final User contact;

  /// Participants of the volunteering
  final List<User> participants;

  /// Date when volunteering occurs
  final DateTime date;

  /// Location of the volunteering
  final LatLng location;

  /// Organiser of the volunteering
  /// TODO: validate requirements. Who is organizer? User or center?

  Volunteering(this.title, this.description, this.contact, this.participants,
      this.date, this.location);
}
