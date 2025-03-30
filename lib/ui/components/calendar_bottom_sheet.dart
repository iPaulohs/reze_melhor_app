import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:reze_melhor/application/states/color_app_controller.dart';
import 'package:reze_melhor/application/states/selected_day_controller.dart';
import 'package:reze_melhor/application/states/theme_mode_controller.dart';
import 'package:reze_melhor/ui/components/custom_button.dart';
import 'package:reze_melhor/ui/theme/color_theme.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarBottomSheet extends StatelessWidget {
  CalendarBottomSheet({super.key});

  final selectedDayController = Get.find<SelectedDayController>();
  final colorAppController = Get.find<ColorAppController>();
  final themeModeController = Get.find<ThemeModeController>();
  final adaptativeColor = Get.find<AdaptativeColor>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Obx(
      () => SizedBox(
        height: height * 0.75,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: TableCalendar(
                headerStyle: HeaderStyle(
                  titleCentered: true,
                  leftChevronIcon: SvgPicture.asset(
                    height: height * 0.02,
                    "assets/svg/angulo-esquerdo.svg",
                    colorFilter: ColorFilter.mode(
                      colorAppController.appColor.value.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                  rightChevronIcon: SvgPicture.asset(
                    height: height * 0.02,
                    "assets/svg/angulo-direito.svg",
                    colorFilter: ColorFilter.mode(
                      colorAppController.appColor.value.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                focusedDay: selectedDayController.selectedDayObs.value,
                selectedDayPredicate:
                    (day) => isSameDay(
                      selectedDayController.selectedDayObs.value,
                      day,
                    ),
                locale: "pt-BR",
                firstDay: DateTime.utc(2024, 1, 1),
                lastDay: DateTime.utc(2025, 12, 31),
                calendarFormat: CalendarFormat.month,
                availableCalendarFormats: {CalendarFormat.month: 'Mês'},
                onDaySelected: (selectedDay, focusedDay) {
                  selectedDayController.changeSelectedDay(
                    selectedDay,
                    focusedDay,
                  );
                },
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekendStyle: TextStyle(
                    color: colorAppController.appColor.value.primary,
                  ),
                ),
                calendarBuilders: CalendarBuilders(
                  defaultBuilder: (context, date, _) {
                    return Container(
                      margin: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: adaptativeColor.getAdaptiveColorSuave(context),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          '${date.day}',
                          style: TextStyle(
                            color: adaptativeColor.getAdaptiveColor(context),
                          ),
                        ),
                      ),
                    );
                  },
                  selectedBuilder: (context, date, _) {
                    return Container(
                      margin: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: colorAppController.appColor.value.secondary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          '${date.day}',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                  todayBuilder: (context, date, _) {
                    return Container(
                      margin: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: adaptativeColor.getAdaptiveColorSuave(context),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: colorAppController.appColor.value.primary,
                        ),
                      ),
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1,
                                color:
                                    colorAppController.appColor.value.primary,
                              ),
                            ),
                          ),
                          child: Text(
                            '${date.day}',
                            style: TextStyle(
                              color: adaptativeColor.getAdaptiveColor(context),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  headerTitleBuilder: (context, day) {
                    return Column(
                      children: [
                        Text(
                          DateFormat("MMMM", "pt_BR")
                              .format(
                                selectedDayController.selectedDayObs.value,
                              )
                              .toUpperCase(),
                          style: GoogleFonts.montserrat(),
                        ),
                        Text(day.year.toString()),
                      ],
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              spacing: width * 0.025,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: CustomButton(
                    color: colorAppController.appColor.value.secondary,
                    onPress: () {
                      selectedDayController.changeSelectedDay(
                        DateTime.now(),
                        DateTime.now(),
                      );
                    },
                    textButton: "HOJE",
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: CustomButton(
                      textColor: colorAppController.appColor.value.tertiary,
                      onPress: () {},
                      textButton: "FECHAR"
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
