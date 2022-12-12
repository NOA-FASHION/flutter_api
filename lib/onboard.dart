import 'package:flutter/material.dart';
import 'package:flutter_api/route/app_route.dart';
import 'package:flutter_api/theme/app_theme.dart';
import 'package:flutter_api/view/login/login_view.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'controller/login/authentication_manager.dart';
import 'route/app_page.dart';
import 'view/dashboard/dashboard_screen.dart';

class OnBoard extends StatelessWidget {
  const OnBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthenticationManager _authManager = Get.find();

    return Obx(() {
      return _authManager.isLogged.value
          ? GetMaterialApp(
              getPages: AppPage.list,
              initialRoute: AppRoute.dashboardScreen,
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              themeMode: ThemeMode.light,
            )
          : LoginView();
    });
  }
}
