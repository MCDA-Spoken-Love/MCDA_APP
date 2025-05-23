import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:mcda_app/core/configs/theme/my_colors_extension.dart';

class Navbar extends StatelessWidget {
  const Navbar({
    super.key,
    required this.onItemTapped,
    required this.currentPageIndex,
  });
  final int currentPageIndex;
  final ValueChanged<int> onItemTapped;

  @override
  Widget build(BuildContext context) {
    ThemeData colors = Theme.of(context);
    final MyColorsExtension myColors =
        Theme.of(context).extension<MyColorsExtension>()!;

    Color colorSwitcher(int index) =>
        currentPageIndex == index
            ? colors.colorScheme.onPrimary
            : colors.colorScheme.onSurface;

    TextStyle fontStyleSwitcher(int index) =>
        currentPageIndex == index
            ? TextStyle(fontWeight: FontWeight.bold)
            : TextStyle(fontWeight: FontWeight.normal);

    return Container(
      color: myColors.translucentColor,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 6.0),
        child: CurvedNavigationBar(
          onTap: onItemTapped,
          index: currentPageIndex,
          animationDuration: Duration(milliseconds: 300),
          buttonBackgroundColor: colors.colorScheme.primary,
          animationCurve: Curves.decelerate,
          color: myColors.translucentColor as Color,
          backgroundColor: colors.scaffoldBackgroundColor,
          items: <CurvedNavigationBarItem>[
            CurvedNavigationBarItem(
              child: Icon(
                currentPageIndex == 0
                    ? Icons.settings
                    : Icons.settings_outlined,
                size: 30,
                color: colorSwitcher(0),
              ),
              label: 'Settings',
              labelStyle: fontStyleSwitcher(0),
            ),
            CurvedNavigationBarItem(
              child: Icon(
                currentPageIndex == 1 ? Icons.favorite : Icons.favorite_border,
                size: 30,
                color: colorSwitcher(1),
              ),
              label: 'Favorite',
              labelStyle: fontStyleSwitcher(1),
            ),
            CurvedNavigationBarItem(
              child: Icon(
                currentPageIndex == 2
                    ? Icons.account_circle
                    : Icons.account_circle_outlined,
                size: 30,
                color: colorSwitcher(2),
              ),
              label: 'Account',
              labelStyle: fontStyleSwitcher(2),
            ),
          ],
        ),
      ),
    );
  }
}
