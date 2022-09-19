import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:task_for_work_by_api/binding.dart';
import 'package:task_for_work_by_api/components/lanqueages.dart';
import 'package:task_for_work_by_api/views/main/home_screen.dart';
import 'package:task_for_work_by_api/views/show%20movie/single_movie_screen.dart';
import 'package:task_for_work_by_api/views/splash_screen.dart';
import 'components/appcolors.dart';
import 'components/theme.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: AppColors.statusBarColor,
    systemNavigationBarColor: AppColors.statusBarColor,
    statusBarBrightness: Brightness.light,
    systemNavigationBarIconBrightness: Brightness.light,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: [
        GetPage(
          name: routHomeScreen,
          page: () => HomeScreen(),
          binding: MainBinding(),
        ),
        GetPage(
          name: routSingleMovieScreen,
          page: () => SinglMovieScreen(),
          binding: MainBinding(),
        ),
      ],
      debugShowCheckedModeBanner: false,
      translations: Languages(),
      locale: const Locale('en'),
      theme: Themes.appTheme,
      home: const SplashScreen(),
    );
  }
}

String routMainScreen = "/MainScreen";
String routSingleMovieScreen = "/SingleMovieScreen";
String routHomeScreen = "/HomeScreen";
