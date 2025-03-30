import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moon_design/moon_design.dart';

import '../theme/color_theme.dart';

class CustomDropdown extends StatefulWidget {
  const CustomDropdown({
    super.key,
    required this.onChanged,
    required this.items,
    required this.label,
    this.icon,
    this.validator
  });

  final ValueChanged<String?> onChanged;
  final List<String> items;
  final String label;
  final Icon? icon;
  final FormFieldValidator<String?>? validator;

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  final adaptativeColor = Get.find<AdaptativeColor>();
  final _focusNode = FocusNode();
  String? _selectedItem;
  bool _showDropdown = false;

  void _handleSelect(String item) {
    setState(() {
      _selectedItem = item;
      _showDropdown = false;
      _focusNode.unfocus();
    });
    widget.onChanged(item);
  }

  void _toggleDropdown() {
    setState(() {
      _showDropdown = !_showDropdown;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: MoonDropdown(
        backgroundColor: adaptativeColor.getAdaptiveColorSuave(context),
        show: _showDropdown,
        constrainWidthToChild: true,
        onTapOutside: () => setState(() => _showDropdown = false),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: widget.items.map((String item) {
            return MoonMenuItem(
              onTap: () => _handleSelect(item),
              label: Text(
                item,
                style: GoogleFonts.montserrat(
                  color: adaptativeColor.getAdaptiveColor(context),
                ),
              ),
            );
          }).toList(),
        ),
        child: TextFormField(
          validator: widget.validator,
          focusNode: _focusNode,
          readOnly: true,
          onTap: _toggleDropdown,
          decoration: InputDecoration(
            prefixIcon: widget.icon,
            filled: true,
            fillColor: adaptativeColor.getAdaptiveColorSuave(context),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            labelText: widget.label,
            labelStyle: GoogleFonts.montserrat(color: Colors.grey[700]),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.red,
                width: .5
              )
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 12,
            ),
            suffixIcon: MoonButton.icon(
              buttonSize: MoonButtonSize.xs,
              hoverEffectColor: Colors.transparent,
              onTap: _toggleDropdown,
              icon: AnimatedRotation(
                duration: const Duration(milliseconds: 200),
                turns: _showDropdown ? -0.5 : 0,
                child: Icon(
                  MoonIcons.controls_chevron_down_16_light,
                  color: adaptativeColor.getAdaptiveColor(context),
                ),
              ),
            ),
          ),
          controller: TextEditingController(text: _selectedItem ?? ""),
        ),
      ),
    );
  }
}