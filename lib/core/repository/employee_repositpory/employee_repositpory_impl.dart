import 'package:get_it/get_it.dart';
import 'package:task/core/network/api_client.dart';
import 'package:task/core/repository/employee_repositpory/employee_repositpory.dart';
import 'package:task/ui/employee_detail/model/checkin_detail_model.dart';
import 'package:task/ui/home/controller/home_controller.dart';
import 'package:task/ui/home/model/employee_model.dart';

class EmployeeRepositoryImpl extends EmployeeRepository {
  final apiClient = GetIt.I.get<ApiClient>();

  @override
  Future<List<EmployeeModel>> getAllEmployeeList(
      int page, ApiFilter apiFilter) async {
    return await apiClient.getAllEmployeeList(page, apiFilter);
  }

  @override
  Future<List<CheckingDetailModel>> getAllChecking(String id) async {
    return await apiClient.getAllChecking(id);
  }

  @override
  Future<List<EmployeeModel>> getSearchedEmployeeList(
      int page, String? name, String? countryName) async {
    return await apiClient.getSearchedEmployeeList(page, name, countryName);
  }
}
