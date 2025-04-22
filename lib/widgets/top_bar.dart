import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TopBar extends StatefulWidget implements PreferredSizeWidget {
  final double height;

  const TopBar({super.key, required this.height});

  @override
  State<TopBar> createState() => _TopBarState();

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class _TopBarState extends State<TopBar> {
  String theme = 'light';
  @override
  void initState() {
    super.initState();
    loadSharedPrefs();
  }

  Future<void> loadSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      theme = prefs.getString('theme') ?? 'light';
    });
  }

  Future<void> _changeTheme() async {
    final prefs = await SharedPreferences.getInstance();
    String currentTheme = prefs.getString('theme') ?? 'light';
    String newTheme = currentTheme == 'light' ? 'dark' : 'light';
    setState(() {
      theme = newTheme;
      prefs.setString('theme', newTheme);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Top Bar value: $theme'),
      actions: [
        Center(
          child: IconButton(
            icon: Icon(Icons.dark_mode),
            onPressed: _changeTheme,
          ),
        ),
      ],
    );
  }
}
