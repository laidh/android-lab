import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:volunteer/models/event.dart';
import 'package:volunteer/models/review.dart';
import 'package:volunteer/models/social_media.dart';

/// Represents volunteering center
class VolunteeringCenter {
  /// Profile photo of the center
  final String photoUrl;

  /// Mission, vision, values and other about information
  final String description;

  /// Volunteering center social media references
  final List<SocialMedia> socials;

  /// Location of the center
  final LatLng location;

  /// Services that center provides
  /// TODO: Validate requirements
  /// final List<VolunteeringService> services;

  /// Pass and upcoming events of the center
  final List<Event> events;

  /// User reviews for the volunteering center
  final List<Review> reviews;

  VolunteeringCenter(this.photoUrl, this.description, this.socials,
      this.location, this.events, this.reviews);
}
