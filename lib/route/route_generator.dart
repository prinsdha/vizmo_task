import 'package:get/get.dart';
import 'package:task/ui/base/base_screen.dart';
import 'package:task/ui/employee_detail/employee_detail_screen.dart';
import 'package:task/ui/employee_detail/widget/checking_detail_screen.dart';
import 'package:task/ui/search/search_screen.dart';

final List<GetPage<dynamic>> routes = [
  GetPage(name: BaseScreen.routeName, page: () => const BaseScreen()),
  GetPage(
      name: EmployeeDetailScreen.routeName,
      page: () => const EmployeeDetailScreen()),
  GetPage(
      name: CheckingDetailScreen.routeName,
      page: () => const CheckingDetailScreen()),
  GetPage(name: SearchScreen.routeName, page: () => const SearchScreen()),
];
