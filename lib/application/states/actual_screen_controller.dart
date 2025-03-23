import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ActualScreenController extends GetxController {
  RxInt actualPosition = 0.obs;

  void toggleActualPosition(int index){
    actualPosition.value = index;
    update();
  }
}