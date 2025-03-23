import 'package:get/state_manager.dart';

class SelectedDayController extends GetxController {
  Rx<DateTime> selectedDayObs = DateTime.now().obs;
  Rx<DateTime> focusedDayObs = DateTime.now().obs;

void changeSelectedDay(DateTime selectedDay, DateTime focusedDay) {
  selectedDayObs.value = selectedDay;
  focusedDayObs.value = focusedDay;
}
}
