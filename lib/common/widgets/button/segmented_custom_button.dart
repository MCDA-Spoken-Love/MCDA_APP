import 'package:flutter/material.dart';
import 'package:mcda_app/core/configs/theme/my_colors_extension.dart';

enum Calendar { day, week, month, year }

class SegmentedCustomButton<T extends Enum> extends StatelessWidget {
  const SegmentedCustomButton({
    super.key,
    required this.options,
    required this.selected,
    required this.onSelectionChanged,
    required this.labelBuilder,
  });
  final List<T> options;
  final T selected;
  final void Function(T) onSelectionChanged;
  final Widget Function(T) labelBuilder;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    MyColorsExtension myColors = theme.extension<MyColorsExtension>()!;
    return SizedBox(
      width: double.infinity,
      child: SegmentedButton<Enum>(
        style: SegmentedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 34, vertical: 26),
          selectedBackgroundColor: myColors.extensionPrimary,
          side: BorderSide(width: 2, color: myColors.extensionPrimary as Color),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        showSelectedIcon: false,
        segments:
            options
                .map((e) => ButtonSegment(value: e, label: labelBuilder(e)))
                .toList(),
        selected: <T>{selected},
        onSelectionChanged: (Set<Enum> newSelection) {
          if (newSelection.isNotEmpty) {
            onSelectionChanged(newSelection.first as T);
          }
        },
      ),
    );
  }
}
