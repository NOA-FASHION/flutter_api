import 'package:flutter_api/route/app_route.dart';
import 'package:flutter_api/view/dashboard/dashboard_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../view/dashboard/dashboard_binding.dart';
import '../view/splash_view.dart';

class AppPage {
  static var list = [
    GetPage(
        name: AppRoute.dashboardScreen,
        page: () => DashboardScreen(),
        binding: DashboardBinding())
  ];
}
