import 'package:url_launcher/url_launcher.dart';

class Email {
  static Future openLink({required String url}) => _launchURL(url);

  static _launchURL(String url) async {
    await launch(url);
  }

  static Future sendEmail(
      {required String toEmail,
      required String subject,
      required String body}) async {
    final url =
        'mailto:$toEmail?subject=${Uri.encodeFull(subject)}&body=${Uri.encodeFull(body)}';

    await _launchURL(url);
  }
}
