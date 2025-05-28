enum ThemeChoices { light, dark, system }

enum ColorSchemes {
  defaultColorScheme('Default', 'main'),
  dynamicColorScheme('Dynamic', 'dynamic'),
  iosColorScheme('iOS', 'ios'),
  blueColorScheme('Blue', 'blue'),
  greenColorScheme('Green', 'green'),
  redColorScheme('Red', 'red'),
  yellowColorScheme('Yellow', 'yellow'),
  purpleColorScheme('Purple', 'purple'),
  orangeColorScheme('Orange', 'orange'),
  blackWhiteColorScheme('Black & White', 'bw');

  const ColorSchemes(this.title, this.scheme);
  final String title;
  final String scheme;
}
