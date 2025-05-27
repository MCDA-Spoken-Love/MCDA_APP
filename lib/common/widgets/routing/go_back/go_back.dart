import 'package:flutter/material.dart';
import 'package:mcda_app/common/widgets/containers/custom_container.dart';
import 'package:mcda_app/core/configs/theme/my_colors_extension.dart';

class GoBack extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onPressed;

  @override
  Size get preferredSize => const Size.fromHeight(72);
  const GoBack({super.key, required this.title, this.onPressed});

  @override
  State<GoBack> createState() => _GoBackState();
}

class _GoBackState extends State<GoBack> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Theme.of(context).extension<MyColorsExtension>()!;
    return Padding(
      padding: const EdgeInsets.only(
        top: 40.0,
        left: 20.0,
        right: 20.0,
        bottom: 0.0,
      ),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  widget.onPressed ?? Navigator.of(context).pop();
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(theme.primaryColor),
                  fixedSize: WidgetStateProperty.all(Size(40, 40)),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                ),
                icon: Icon(Icons.arrow_back, size: 24),
              ),
              SizedBox(width: 16),
              Text(
                widget.title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 10),
          CustomContainer(
            position: 'unique',
            paddings: EdgeInsets.all(2.0),
            child: SizedBox(height: 1),
          ),
        ],
      ),
    );
  }
}
