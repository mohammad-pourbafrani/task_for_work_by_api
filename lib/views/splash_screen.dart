import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_for_work_by_api/components/appcolors.dart';
import 'package:task_for_work_by_api/components/my_componenets.dart';
import 'package:task_for_work_by_api/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 4)).then((value) {
      Get.offAndToNamed(routHomeScreen);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.scaffoldColor,
        body: Center(
          child: loading(),
        ),
      ),
    );
  }
}
