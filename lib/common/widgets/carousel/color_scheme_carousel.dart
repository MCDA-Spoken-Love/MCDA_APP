import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:mcda_app/core/configs/theme/app_theme.dart';
import 'package:mcda_app/core/configs/theme/my_colors_extension.dart';
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
      final scheme = themeOptions['scheme']!;
      final index = ColorSchemes.values.indexWhere((e) => e.scheme == scheme);
      setState(() {
        selectedScheme = scheme;
        controller.animateTo(
          index * 10,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      });
    });
  }

  void changeScheme(String scheme, ThemeNotifier themeNotifier, int index) {
    setState(() {
      selectedScheme = scheme;
    });
    controller.animateTo(
      index * 100,
      duration: Duration(milliseconds: 300),
      curve: Curves.ease,
    );
    themeNotifier.toggleColorScheme(scheme);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ThemeNotifier themeNotifier, child) {
        return ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 220),
          child: ListView.builder(
            controller: controller,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 12),
            physics: BouncingScrollPhysics(),
            itemCount: ColorSchemes.values.length,
            itemBuilder: (context, index) {
              final colorScheme = ColorSchemes.values[index];
              return HeroLayoutCard(
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

class HeroLayoutCard extends StatefulWidget {
  const HeroLayoutCard({
    super.key,
    required this.colorScheme,
    required this.isSelected,
    required this.onSelected,
  });
  final ColorSchemes colorScheme;
  final bool isSelected;

  final VoidCallback onSelected;

  @override
  State<HeroLayoutCard> createState() => _HeroLayoutCardState();
}

class _HeroLayoutCardState extends State<HeroLayoutCard> {
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
      setState(() => theme = themeOptions['theme'] as String);
    });
  }

  @override
  void didUpdateWidget(HeroLayoutCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    initializeTheme().then((themeOptions) {
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
                          backgroundColor: myColors.translucentColor,
                          toolbarHeight: 26,
                        ),
                        body: Container(
                          color: colors.colorScheme.surface,
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
                            color: myColors.translucentColor,
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
