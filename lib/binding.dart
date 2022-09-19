import 'package:get/get.dart';
import 'package:task_for_work_by_api/controllers/main_controller.dart';

class MainBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(MainController());
  }
}
