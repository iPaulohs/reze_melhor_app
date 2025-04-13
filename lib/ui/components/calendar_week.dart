import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reze_melhor/application/states/color_app_controller.dart';
import 'package:reze_melhor/application/states/selected_day_controller.dart';
import 'package:reze_melhor/application/states/theme_mode_controller.dart';
import 'package:reze_melhor/ui/theme/color_theme.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWeek extends StatelessWidget {
  CalendarWeek({super.key});

  final selectedDayController = Get.find<SelectedDayController>();
  final colorAppController = Get.find<ColorAppController>();
  final themeModeController = Get.find<ThemeModeController>();
  final adaptativeColor = Get.find<AdaptativeColor>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Obx(
      () => Padding(
        padding: EdgeInsets.symmetric(
          vertical: width * 0.035,
          horizontal: height * 0.0075,
        ),
        child: TableCalendar(
          focusedDay: selectedDayController.selectedDayObs.value,
          headerVisible: false,
          selectedDayPredicate:
              (day) =>
                  isSameDay(selectedDayController.selectedDayObs.value, day),
          locale: "pt-BR",
          firstDay: DateTime(DateTime.now().year, DateTime.now().month, 1),
          lastDay: DateTime(DateTime.now().year, DateTime.now().month + 1, 0),
          calendarFormat: CalendarFormat.week,
          availableCalendarFormats: {CalendarFormat.week: 'Semana'},
          onDaySelected: (selectedDay, focusedDay) {
            selectedDayController.changeSelectedDay(selectedDay, focusedDay);
          },
          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: GoogleFonts.montserratAlternates(),
            weekendStyle: GoogleFonts.montserratAlternates(
              color: colorAppController.appColor.value.tertiary,
            ),
          ),
          calendarBuilders: CalendarBuilders(
            disabledBuilder: null,
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
                          color: colorAppController.appColor.value.primary,
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
          ),
        ),
      ),
    );
  }
}
