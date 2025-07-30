import 'package:flutter/material.dart';
import 'package:mcda_app/common/widgets/text/besty_title.dart';

class BestyDropdown extends StatefulWidget {
  final List<Map<String, String>> list;
  final bool isRequired;
  final String label;
  final String? selectedValue;
  final Function(String?)? onChangedCallback;
  const BestyDropdown({
    super.key,
    required this.list,
    this.isRequired = false,
    required this.label,
    this.selectedValue = '',
    this.onChangedCallback,
  });

  @override
  State<BestyDropdown> createState() => _BestyDropdownState();
}

class _BestyDropdownState extends State<BestyDropdown> {
  void _onChanged(String? value) {
    if (widget.onChangedCallback != null) {
      widget.onChangedCallback!(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeColors = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        BestyTitle(
          title: widget.label,
          textAlign: TextAlign.start,
          color: themeColors.canvasColor,
          fontSize: 16,
        ),
        SizedBox(height: 8),

        DropdownButtonFormField<String>(
          style: TextStyle(color: themeColors.primaryColor, fontSize: 16),

          hint: Text('Select an option'),
          decoration: InputDecoration(
            filled: true,
            fillColor: themeColors.colorScheme.tertiary,
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              borderSide: BorderSide(
                color: themeColors.colorScheme.error,
                width: 3,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              borderSide: BorderSide(color: themeColors.hintColor, width: 3),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              borderSide: BorderSide(color: themeColors.hintColor, width: 3),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(12.0)),
              borderSide: BorderSide(color: themeColors.hintColor, width: 3),
            ),
          ),
          items:
              widget.list.map((map) {
                return DropdownMenuItem<String>(
                  value: map['value'] as String,
                  child: Text(map['name']!),
                );
              }).toList(),
          onChanged: _onChanged,
        ),
      ],
    );
  }
}
