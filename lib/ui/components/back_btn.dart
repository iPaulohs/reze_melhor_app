import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../application/states/color_app_controller.dart';

class BackBtn extends StatelessWidget {
   BackBtn({super.key, this.onTap});

  final appColorController = Get.find<ColorAppController>();
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
      onTap: onTap ?? () => Get.back(),
      child: Container(
        decoration: BoxDecoration(
          color: appColorController.appColor.value.primary,
          borderRadius: BorderRadius.circular(15)
        ),
        child: Center(
          child: SvgPicture.asset(
            "assets/svg/back.svg",
            colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
        ),
      ),
    );
  }
}
