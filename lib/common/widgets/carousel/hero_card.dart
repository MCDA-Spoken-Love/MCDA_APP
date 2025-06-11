import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:mcda_app/core/configs/theme/app_theme.dart';
import 'package:mcda_app/core/configs/theme/my_colors_extension.dart';
import 'package:mcda_app/core/constants/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HeroCard extends StatefulWidget {
  const HeroCard({
    super.key,
    required this.colorScheme,
    required this.isSelected,
    required this.onSelected,
  });
  final ColorSchemes colorScheme;
  final bool isSelected;

  final VoidCallback onSelected;

  @override
  State<HeroCard> createState() => _HeroCardState();
}

class _HeroCardState extends State<HeroCard> {
  String theme = 'light';

  Future<Map<String, String>> initializeTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      "theme": prefs.getString('theme') ?? 'light',
      "scheme": prefs.getString('scheme') ?? 'main',
    };
  }

  @override
  void initState() {
    super.initState();
    initializeTheme().then((themeOptions) {
      if (!mounted) return;
      setState(() => theme = themeOptions['theme'] as String);
    });
  }

  @override
  void didUpdateWidget(HeroCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    initializeTheme().then((themeOptions) {
      if (!mounted) return;

      setState(() => theme = themeOptions['theme'] as String);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        final Map<String, ThemeData> colorSchemes = {
          "main-light":
              AppTheme(
                darkDynamic: darkDynamic,
                lightDynamic: lightDynamic,
              ).mainLightTheme,
          "main-dark":
              AppTheme(
                darkDynamic: darkDynamic,
                lightDynamic: lightDynamic,
              ).mainDarkTheme,
          "dynamic-light":
              AppTheme(
                darkDynamic: darkDynamic,
                lightDynamic: lightDynamic,
              ).dynamicLight,
          "dynamic-dark":
              AppTheme(
                darkDynamic: darkDynamic,
                lightDynamic: lightDynamic,
              ).dynamicDark,
          "ios-light":
              AppTheme(
                darkDynamic: darkDynamic,
                lightDynamic: lightDynamic,
              ).iosLightTheme,
          "ios-dark":
              AppTheme(
                darkDynamic: darkDynamic,
                lightDynamic: lightDynamic,
              ).iosDarkTheme,
          "blue-light":
              AppTheme(
                darkDynamic: darkDynamic,
                lightDynamic: lightDynamic,
              ).blueLightTheme,
          "blue-dark":
              AppTheme(
                darkDynamic: darkDynamic,
                lightDynamic: lightDynamic,
              ).blueDarkTheme,
          "green-light":
              AppTheme(
                darkDynamic: darkDynamic,
                lightDynamic: lightDynamic,
              ).greenLightTheme,
          "green-dark":
              AppTheme(
                darkDynamic: darkDynamic,
                lightDynamic: lightDynamic,
              ).greenDarkTheme,
          "red-light":
              AppTheme(
                darkDynamic: darkDynamic,
                lightDynamic: lightDynamic,
              ).redLightTheme,
          "red-dark":
              AppTheme(
                darkDynamic: darkDynamic,
                lightDynamic: lightDynamic,
              ).redDarkTheme,
          "yellow-light":
              AppTheme(
                darkDynamic: darkDynamic,
                lightDynamic: lightDynamic,
              ).yellowLightTheme,
          "yellow-dark":
              AppTheme(
                darkDynamic: darkDynamic,
                lightDynamic: lightDynamic,
              ).yellowDarkTheme,
          "purple-light":
              AppTheme(
                darkDynamic: darkDynamic,
                lightDynamic: lightDynamic,
              ).purpleLightTheme,
          "purple-dark":
              AppTheme(
                darkDynamic: darkDynamic,
                lightDynamic: lightDynamic,
              ).purpleDarkTheme,
          "orange-light":
              AppTheme(
                darkDynamic: darkDynamic,
                lightDynamic: lightDynamic,
              ).orangeLightTheme,
          "orange-dark":
              AppTheme(
                darkDynamic: darkDynamic,
                lightDynamic: lightDynamic,
              ).orangeDarkTheme,
        };
        var brightness = MediaQuery.platformBrightnessOf(context).name;

        var colorName =
            '${widget.colorScheme.scheme}-${theme == 'system' ? brightness : theme}';
        ThemeData? colors = colorSchemes[colorName];
        final MyColorsExtension myColors =
            colors!.extension<MyColorsExtension>()!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.colorScheme.title),
            Row(
              children: [
                InkWell(
                  onTap: widget.onSelected,
                  child: SizedBox(
                    width: 122,
                    height: 199,
                    child: Container(
                      foregroundDecoration: BoxDecoration(
                        border:
                            widget.isSelected
                                ? Border.all(
                                  color: colors.highlightColor,
                                  width: 3,
                                )
                                : null,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Scaffold(
                        appBar: AppBar(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(24),
                            ),
                          ),
                          automaticallyImplyLeading: false,
                          backgroundColor: myColors.extensionPrimary,
                          toolbarHeight: 26,
                        ),
                        body: Container(
                          color: colors.canvasColor,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6.0,
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 26,
                                      width: 52,
                                      decoration: BoxDecoration(
                                        color: colors.colorScheme.tertiary,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(3),
                                          bottomLeft: Radius.circular(12),
                                          bottomRight: Radius.circular(12),
                                          topRight: Radius.circular(12),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6.0,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      height: 26,
                                      width: 52,
                                      decoration: BoxDecoration(
                                        color: colors.hintColor,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          bottomLeft: Radius.circular(12),
                                          bottomRight: Radius.circular(12),
                                          topRight: Radius.circular(3),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: 6),
                            ],
                          ),
                        ),
                        bottomNavigationBar: Container(
                          height: 26,
                          decoration: BoxDecoration(
                            color: myColors.extensionPrimary,
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(24),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
              ],
            ),
          ],
        );
      },
    );
  }
}
