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

  late CarouselController controller;

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
    controller = CarouselController(initialItem: 0);
    initializeTheme().then((themeOptions) {
      final scheme = themeOptions['scheme']!;
      final index = ColorSchemes.values.indexWhere((e) => e.scheme == scheme);
      setState(() {
        selectedScheme = scheme;
        controller = CarouselController(initialItem: index);
      });
    });
  }

  void changeScheme(String scheme, ThemeNotifier themeNotifier) {
    setState(() {
      selectedScheme = scheme;
    });
    themeNotifier.toggleColorScheme(scheme);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.sizeOf(context).height;
    return Consumer(
      builder: (context, ThemeNotifier themeNotifier, child) {
        return ConstrainedBox(
          constraints: BoxConstraints(maxHeight: height / 2),
          child: CarouselView.weighted(
            controller: controller,
            itemSnapping: true,
            onTap: (index) {
              final colorScheme = ColorSchemes.values[index];
              changeScheme(colorScheme.scheme, themeNotifier);
            },
            flexWeights: const <int>[7, 1, 1],
            children:
                ColorSchemes.values.map((ColorSchemes colorScheme) {
                  return HeroLayoutCard(
                    colorScheme: colorScheme,
                    isSelected: selectedScheme == colorScheme.scheme,
                  );
                }).toList(),
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
  });
  final ColorSchemes colorScheme;
  final bool isSelected;

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
    final double width = MediaQuery.sizeOf(context).height;
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

        return InkWell(
          borderRadius: BorderRadius.circular(24),
          child: Container(
            decoration: BoxDecoration(
              border:
                  widget.isSelected
                      ? Border.all(color: Colors.blue, width: 3)
                      : null,
              borderRadius: BorderRadius.circular(24),
            ),
            child: OverflowBox(
              maxWidth: width / 3,
              child: Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: <Widget>[
                  ClipRect(
                    child: Scaffold(
                      appBar: AppBar(
                        backgroundColor: colors.primaryColor,
                        title: Text(widget.colorScheme.title),
                      ),
                      body: Container(
                        color: colors.colorScheme.surface,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20.0,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    height: 50,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: colors.colorScheme.tertiary,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(6),
                                        bottomLeft: Radius.circular(24),
                                        bottomRight: Radius.circular(24),
                                        topRight: Radius.circular(24),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20.0,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    height: 50,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: colors.hintColor,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(24),
                                        bottomLeft: Radius.circular(24),
                                        bottomRight: Radius.circular(24),
                                        topRight: Radius.circular(6),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20.0,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    height: 50,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: colors.colorScheme.tertiary,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(6),
                                        bottomLeft: Radius.circular(24),
                                        bottomRight: Radius.circular(24),
                                        topRight: Radius.circular(24),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20.0,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    height: 50,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: colors.hintColor,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(24),
                                        bottomLeft: Radius.circular(24),
                                        bottomRight: Radius.circular(24),
                                        topRight: Radius.circular(6),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                      bottomNavigationBar: BottomAppBar(
                        height: 60,
                        color: myColors.translucentColor,
                        child: Container(
                          constraints: BoxConstraints(maxWidth: 25),
                          decoration: BoxDecoration(
                            color: colors.primaryColor,
                            borderRadius: BorderRadius.all(Radius.circular(24)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
