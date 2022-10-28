import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:task/core/network/utils/api_constant.dart';
import 'package:task/core/network/utils/error_util.dart';
import 'package:task/core/repository/employee_repositpory/employee_repositpory.dart';
import 'package:task/ui/home/model/employee_model.dart';
import 'package:task/ui/ui_failure/ui_result.dart';

class SearchController extends GetxController {
  final repo = GetIt.I.get<EmployeeRepository>();

  String? countryName;
  String? employeeName;

  List<EmployeeModel> searchedEmployeeList = [];

  bool isLoading = false;
  UiFailure? uiFailure;

  int page = 1;

  void retry() {
    fetchPage();
  }

  void searchEmployee(String? countryName, String? employeeName) {
    searchedEmployeeList.clear();
    page = 1;
    this.countryName = countryName;
    this.employeeName = employeeName;
    fetchPage();
  }

  Future<void> fetchPage() async {
    if (page.isNegative ||
        isLoading ||
        (countryName == null && employeeName == null)) {
      return;
    }
    try {
      uiFailure = null;
      isLoading = true;
      update();

      final response =
          await repo.getSearchedEmployeeList(page, employeeName, countryName);

      searchedEmployeeList.addAll(response);
      if (Pagination.maxEmployeeData > response.length) {
        page = -1;
      } else {
        page = page + 1;
      }
    } catch (error, stackTrace) {
      uiFailure = ErrorUtil.getUiFailureFromException(error, stackTrace);
      debugPrintStack(stackTrace: stackTrace);
    } finally {
      isLoading = false;
      update();
    }
  }
}
