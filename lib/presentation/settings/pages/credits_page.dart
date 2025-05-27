import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mcda_app/common/widgets/custom_scaffold/custom_scaffold.dart';
import 'package:mcda_app/common/widgets/routing/go_back/go_back.dart';
import 'package:mcda_app/core/configs/theme/my_colors_extension.dart';
import 'package:url_launcher/url_launcher.dart';

class CreditsPage extends StatelessWidget {
  const CreditsPage({super.key});

  // URLs for the social links
  final String instagramUrl = "https://www.instagram.com/majuu_bix/?hl=pt-br";
  final String githubUrl = "https://github.com/MatheusBlanco";

  // Helper function to launch URLs
  Future<void> launchUrlInBrowser(String url) async {
    final Uri urlParsed = Uri.parse(url);

    if (await canLaunchUrl(urlParsed)) {
      await launchUrl(urlParsed, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final MyColorsExtension myColors =
        Theme.of(context).extension<MyColorsExtension>()!;
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: myColors.translucentColor, // Status bar color
      ),
    );
    return CustomScaffold.withChild(
      appBarChild: GoBack(title: 'Credits'),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Coding and Design by Matheus Salles Blanco',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              ElevatedButton.icon(
                icon: const Icon(Icons.code),
                label: const Text('GitHub'),
                onPressed: () => launchUrlInBrowser(githubUrl),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(180, 50),
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'Logo by Maria Júlia ',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                icon: const Icon(Icons.camera_alt),
                label: const Text('Instagram'),
                onPressed: () => launchUrlInBrowser(instagramUrl),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple[400],
                  foregroundColor: Colors.white,
                  minimumSize: const Size(180, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
