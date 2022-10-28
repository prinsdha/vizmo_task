import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:task/core/network/utils/api_constant.dart';
import 'package:task/core/repository/employee_repositpory/employee_repositpory.dart';
import 'package:task/ui/home/model/employee_model.dart';
import 'package:task/ui/home/widget/sort_bottomsheet.dart';

class ApiFilter {
  SortBy? sortBy;
  FilterBy? filterBy;

  ApiFilter({this.sortBy, this.filterBy});
}

class HomeController extends GetxController {
  final repo = GetIt.I.get<EmployeeRepository>();

  ApiFilter _apiFilter =
      ApiFilter(filterBy: FilterBy.none, sortBy: SortBy.ascending);

  ApiFilter get apiFilter => _apiFilter;

  set apiFilter(ApiFilter value) {
    _apiFilter = value;
    pagingController.refresh();
  }

  final PagingController<int, EmployeeModel> pagingController =
      PagingController(firstPageKey: 1);

  Future<void> _fetchPage(int pageKey) async {
    try {
      final response = await repo.getAllEmployeeList(pageKey, apiFilter);
      final isLastPage = response.length < Pagination.maxEmployeeData;
      if (isLastPage) {
        pagingController.appendLastPage(response);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(response, nextPageKey);
      }
    } catch (error, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      pagingController.error = error;
    }
  }

  @override
  void onInit() {
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.onInit();
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }
}
