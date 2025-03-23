import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:reze_melhor/ui/theme/color_theme.dart';

class IconAsset extends StatelessWidget {
  IconAsset({
    super.key,
    required this.assetName,
    this.h,
    this.w,
    this.colorType = ColorType.normal,
    this.color = Colors.transparent,
  });

  final String assetName;
  final double? w;
  final double? h;
  final ColorType colorType;
  final Color color;
  final AdaptativeColor adaptativeColor = Get.find<AdaptativeColor>();

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetName,
      width: w,
      height: h,
      colorFilter: ColorFilter.mode(
        color == Colors.transparent
            ? adaptativeColor.getAdaptiveColor(context)
            : color,
        BlendMode.srcIn,
      ),
    );
  }
}

enum ColorType { normal, inverted, color }
