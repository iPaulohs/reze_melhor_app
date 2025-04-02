import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/color_theme.dart';

class FotoPerfil extends StatelessWidget {
  FotoPerfil({super.key});

  final adaptativeColor = Get.find<AdaptativeColor>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircleAvatar(
            radius: width * 0.1,
            child: Image.asset(
              'assets/img/rm_icon_transparent.png',
              color: adaptativeColor.getAdaptiveColor(context),
            ),
          );
        }

        if (snapshot.hasData) {
          User? user = snapshot.data;
          return CircleAvatar(
            backgroundImage: NetworkImage(user?.photoURL ?? ''),
            radius: width * 0.1,
          );
        } else {
          return CircleAvatar(
            radius: width * 0.1,
            child: Image.asset(
              'assets/img/rm_icon_transparent.png',
              color: adaptativeColor.getAdaptiveColor(context),
            ),
          );
        }
      },
    );
  }
}
