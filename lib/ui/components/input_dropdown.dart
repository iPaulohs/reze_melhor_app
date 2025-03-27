import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moon_design/moon_design.dart';

import '../theme/color_theme.dart';

class GenderDropdown extends StatefulWidget {
  const GenderDropdown({super.key, required this.onChanged});

  final ValueChanged<String?> onChanged;

  @override
  State<GenderDropdown> createState() => _GenderDropdownState();
}

class _GenderDropdownState extends State<GenderDropdown> {
  final adaptativeColor = Get.find<AdaptativeColor>();
  final _focusNode = FocusNode();
  String? _selectedGender;
  bool _showDropdown = false;

  final List<String> _genders = ["Masculino", "Feminino"];

  void _handleSelect(String gender) {
    setState(() {
      _selectedGender = gender;
      _showDropdown = false;
      _focusNode.unfocus();
    });
    widget.onChanged(gender);
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
          children: _genders.map((String gender) {
            return MoonMenuItem(
              onTap: () => _handleSelect(gender),
              label: Text(
                gender,
                style: GoogleFonts.montserrat(
                  color: adaptativeColor.getAdaptiveColor(context)
                ),
              ),
            );
          }).toList(),
        ),
        child: TextField(
          focusNode: _focusNode,
          readOnly: true,
          onTap: _toggleDropdown,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.male),
            filled: true,
            fillColor: adaptativeColor.getAdaptiveColorSuave(context),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            labelText: "Selecione o gênero",
            labelStyle: GoogleFonts.montserrat(),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            suffixIcon: MoonButton.icon(
              buttonSize: MoonButtonSize.xs,
              hoverEffectColor: Colors.transparent,
              onTap: _toggleDropdown,
              icon: AnimatedRotation(
                duration: const Duration(milliseconds: 200),
                turns: _showDropdown ? -0.5 : 0,
                child: Icon(MoonIcons.controls_chevron_down_16_light, color: adaptativeColor.getAdaptiveColor(context),),
              ),
            ),
          ),
          controller: TextEditingController(text: _selectedGender ?? ""),
        ),
      ),
    );
  }
}