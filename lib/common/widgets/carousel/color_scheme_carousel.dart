import 'package:flutter/material.dart';
import 'package:mcda_app/common/utils/device_info.dart';
import 'package:mcda_app/common/widgets/carousel/hero_card.dart';
import 'package:mcda_app/core/constants/colors.dart';
import 'package:mcda_app/core/provider/theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ColorSchemeCarousel extends StatefulWidget {
  const ColorSchemeCarousel({super.key});

  @override
  State<ColorSchemeCarousel> createState() => _ColorSchemeCarouselState();
}

class _ColorSchemeCarouselState extends State<ColorSchemeCarousel> {
  String selectedScheme =
      ColorSchemes.values[1].scheme; // Default or from prefs
  ScrollController controller = ScrollController();
  Map<String, String>? deviceInfo;

  Future<void> initializeTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> themeOptions = {
      "theme": prefs.getString('theme') ?? 'light',
      "scheme": prefs.getString('scheme') ?? 'main',
    };
    final scheme = themeOptions['scheme']!;
    final index = ColorSchemes.values.indexWhere((e) => e.scheme == scheme);

    if (!mounted) return;
    setState(() {
      selectedScheme = scheme;
      controller.animateTo(
        index * 122,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  Future<void> getDeviceInfo() async {
    Map<String, String> info = await getOs();
    setState(() => deviceInfo = info);
  }

  @override
  void initState() {
    super.initState();
    getOs();
    initializeTheme();
  }

  void changeScheme(String scheme, ThemeNotifier themeNotifier, int index) {
    if (!mounted) return;
    setState(() {
      selectedScheme = scheme;
    });
    controller.animateTo(
      index * 122,
      duration: Duration(milliseconds: 300),
      curve: Curves.ease,
    );
    themeNotifier.toggleColorScheme(scheme);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<ColorSchemes> availableSchemes =
        ColorSchemes.values.where((scheme) {
          if (scheme == ColorSchemes.dynamicColorScheme) {
            if (deviceInfo != null &&
                deviceInfo!['os'] == 'android' &&
                int.tryParse(deviceInfo!['androidVersion'] ?? '0') != null &&
                int.parse(deviceInfo!['androidVersion']!) >= 12) {
              return true;
            }
            return false;
          }
          return true;
        }).toList();

    return Consumer(
      builder: (context, ThemeNotifier themeNotifier, child) {
        return ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 220),
          child: ListView.builder(
            controller: controller,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 12),
            itemCount: availableSchemes.length,
            itemBuilder: (context, index) {
              final colorScheme = availableSchemes[index];
              return HeroCard(
                colorScheme: colorScheme,
                isSelected: selectedScheme == colorScheme.scheme,
                onSelected: () {
                  changeScheme(colorScheme.scheme, themeNotifier, index);
                },
              );
            },
          ),
        );
      },
    );
  }
}
