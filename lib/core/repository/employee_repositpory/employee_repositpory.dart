import 'package:task/ui/employee_detail/model/checkin_detail_model.dart';
import 'package:task/ui/home/controller/home_controller.dart';
import 'package:task/ui/home/model/employee_model.dart';

abstract class EmployeeRepository {
  Future<List<EmployeeModel>> getAllEmployeeList(int page, ApiFilter apiFilter);

  Future<List<CheckingDetailModel>> getAllChecking(String id);

  Future<List<EmployeeModel>> getSearchedEmployeeList(
      int page, String? name, String? countryName);
}
