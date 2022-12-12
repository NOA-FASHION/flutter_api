
import 'package:get/get.dart';

class DashoardController extends GetxController {
  static DashoardController instance = Get.find();
  var tabIndex = 0;

  void updateIndex(int index) {
    tabIndex = index;
    update();
  }
}
