import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reze_melhor/application/states/color_app_controller.dart';
import 'package:reze_melhor/ui/theme/color_theme.dart';

class CustomListTile extends StatelessWidget {
  CustomListTile({
    super.key,
    required this.title,
    required this.trailingAsset,
    this.trailing,
    this.leading,
    required this.onTap,
  });

  final String title;
  final String trailingAsset;
  final Widget? trailing;
  final Widget? leading;
  final GestureTapCallback onTap;
  final ColorAppController appColorController = Get.find<ColorAppController>();
  final AdaptativeColor adaptativeColor = Get.find<AdaptativeColor>();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Obx(
      () => FractionallySizedBox(
        widthFactor: 0.9,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: width * 0.01),
          decoration: BoxDecoration(
            color: adaptativeColor.getAdaptiveColorSuave(context),
            borderRadius: BorderRadius.circular(10),
          ),
          child: GestureDetector(
            onTap: onTap,
            child: ListTile(
              enableFeedback: false,
              dense: true,
              titleAlignment: ListTileTitleAlignment.center,
              title: Text(
                title,
                style: GoogleFonts.montserrat(fontSize: height * 0.018, fontWeight: FontWeight.w500),
              ),
              trailing:
                  trailingAsset.isNotEmpty
                      ? SvgPicture.asset(
                        trailingAsset,
                        colorFilter: ColorFilter.mode(
                          adaptativeColor.getAdaptiveColor(context),
                          BlendMode.srcIn,
                        ),
                      )
                      : trailing,
              leading: leading,
            ),
          ),
        ),
      ),
    );
  }
}
