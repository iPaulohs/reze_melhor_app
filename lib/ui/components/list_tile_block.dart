import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reze_melhor/ui/components/custom_list_tile.dart';
import 'package:reze_melhor/ui/theme/color_theme.dart';

class ListTileBlock extends StatelessWidget {
  ListTileBlock({super.key, required this.titleText, required this.listTiles});

  final adaptativeColor = Get.find<AdaptativeColor>();
  final String titleText;
  final List<CustomListTile> listTiles;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: width * 0.03, top: width * 0.03),
          child: Text(
            titleText,
            style: GoogleFonts.montserratAlternates(
              fontSize: height * 0.0225,
              color: adaptativeColor.getAdaptiveColor(context),
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: 8),
          itemCount: listTiles.length,
          itemBuilder: (context, index) => listTiles[index],
        ),
      ],
    );
  }
}
