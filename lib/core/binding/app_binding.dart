import 'package:get/get.dart';
import 'package:task/ui/employee_detail/controller/employee_detail_controller.dart';
import 'package:task/ui/home/controller/home_controller.dart';
import 'package:task/ui/profile/controller/profile_controller.dart';
import 'package:task/ui/search/controller/search_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut<EmployeeDetailController>(() => EmployeeDetailController(),
        fenix: true);
    Get.lazyPut<ProfileController>(() => ProfileController(), fenix: true);
    Get.lazyPut<SearchController>(() => SearchController(), fenix: true);
  }
}
