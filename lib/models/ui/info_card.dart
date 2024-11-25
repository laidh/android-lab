import 'package:flutter_svg/svg.dart';

///Represent card with information about volunteering
class InfoCard {
  ///Title of the card
  final String title;

  ///Main picture of the card
  final SvgPicture picture;

  ///The link you follow when you click on card
  final String url;

  InfoCard(this.title, this.picture, this.url);
}
