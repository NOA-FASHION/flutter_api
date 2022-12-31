import 'package:flutter_api/controller/controller_mission.dart';
import 'package:get/get.dart';

import '../../controller/controller_user.dart';
import '../../controller/dashboard_controller.dart';
import '../../controller/login/authentication_controler.dart';
import '../../controller/login/login_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DashoardController());
    Get.put(MissionController());
    Get.put(UserController());
    // Get.put(AuthenticationManager());
    // Get.put(LoginViewModel());
  }
}
