enum ThemeChoices { light, dark, system }

enum ColorSchemes {
  defaultColorScheme('Default', 'main'),
  dynamicColorScheme('Dynamic', 'dynamic'),
  iosColorScheme('iOS', 'main');

  const ColorSchemes(this.title, this.scheme);
  final String title;
  final String scheme;
}
