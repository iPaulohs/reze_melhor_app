import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../application/states/color_app_controller.dart';

class BackBtn extends StatelessWidget {
   BackBtn({super.key});

  final appColorController = Get.find<ColorAppController>();


  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
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
      onTap: () => Get.back(),
    );
  }
}
