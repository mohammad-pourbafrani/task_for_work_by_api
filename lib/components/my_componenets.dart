import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:task_for_work_by_api/components/appcolors.dart';

Widget loading() {
  return const SpinKitThreeBounce(
    color: AppColors.white,
    size: 30.0,
  );
}

Widget costumiseInput(
    {required TextEditingController controller,
    required String hintText,
    required IconData icon}) {
  return TextField(
    controller: controller,
    style: Get.textTheme.headline1!.apply(
      color: AppColors.white,
    ),
    decoration: InputDecoration(
      filled: true,
      fillColor: AppColors.backgrandNavColor,
      hintText: hintText,
      hintStyle: Get.textTheme.headline1!.apply(
        color: AppColors.white.withAlpha(100),
      ),
      prefixIcon: Icon(
        icon,
        color: AppColors.white,
      ),
    ),
  );
}

Widget costumiseElvatedButon(Callback callback, String text) {
  return ElevatedButton(
    style: ButtonStyle(
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      backgroundColor: MaterialStateProperty.all(AppColors.backgrandNavColor),
      padding: MaterialStateProperty.all(
        const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
      ),
    ),
    onPressed: callback,
    child: Text(
      text,
      style: Get.textTheme.headline2!.apply(
        color: AppColors.white.withAlpha(200),
      ),
    ),
  );
}

Widget costumiseRoundedContainer(Text text, Color colorBackgroand) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10), color: colorBackgroand),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Center(child: text),
    ),
  );
}
