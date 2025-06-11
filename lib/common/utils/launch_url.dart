import 'package:url_launcher/url_launcher.dart';

Future<void> launchUrlInBrowser(String url) async {
  final Uri urlParsed = Uri.parse(url);

  if (await canLaunchUrl(urlParsed)) {
    await launchUrl(urlParsed, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $url';
  }
}
