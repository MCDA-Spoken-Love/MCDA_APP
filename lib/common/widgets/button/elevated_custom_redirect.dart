import 'package:flutter/material.dart';
import 'package:mcda_app/common/widgets/containers/custom_container.dart';

class ElevatedCustomRedirect extends StatelessWidget {
  final VoidCallback onPressed;
  final String containerPosition;
  final String title;
  final IconData icon;

  const ElevatedCustomRedirect({
    super.key,
    required this.onPressed,
    this.containerPosition = 'unique',
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: Colors.transparent,
        padding: EdgeInsets.zero,
      ),
      onPressed: onPressed,
      child: CustomContainer(
        position: containerPosition,
        paddings: EdgeInsets.all(20.0),

        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 14,
          children: [
            Icon(icon, size: 31, color: theme.colorScheme.onSurface),

            Text(
              title,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
