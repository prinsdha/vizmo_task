import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:task/core/network/utils/error_util.dart';
import 'package:task/ui/employee_detail/model/checkin_detail_model.dart';
import 'package:task/ui/ui_failure/ui_result.dart';
import '../../../core/repository/employee_repositpory/employee_repositpory.dart';

class EmployeeDetailController extends GetxController {
  final repo = GetIt.I.get<EmployeeRepository>();

  List<CheckingDetailModel> checkingDetail = [];

  UiFailure? uiFailure;

  bool isLoading = false;

  Future<void> retry() async {
    await getDetails();
  }

  Future<void> getDetails() async {
    try {
      isLoading = true;
      update();
      uiFailure = null;
      final response = await repo.getAllChecking(Get.arguments.id);
      checkingDetail = response;
    } catch (e, stackTrace) {
      uiFailure = ErrorUtil.getUiFailureFromException(e, stackTrace);
    } finally {
      isLoading = false;
      update();
    }
  }

  @override
  void onInit() {
    getDetails();
    super.onInit();
  }
}
