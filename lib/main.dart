import 'package:flutter/material.dart';
import 'package:flutter_api/route/app_page.dart';
import 'package:flutter_api/route/app_route.dart';
import 'package:flutter_api/theme/app_theme.dart';
import 'package:flutter_api/view/splash_view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashView(),
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,
    );
  }
}
