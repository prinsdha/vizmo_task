import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/core/network/utils/base_response.dart';
import 'package:task/ui/employee_detail/controller/employee_detail_controller.dart';
import 'package:task/ui/employee_detail/widget/checking_detail_screen.dart';
import 'package:task/ui/home/model/employee_model.dart';

class EmployeeDetailScreen extends StatefulWidget {
  static const String routeName = "/employee-detail-screen";

  const EmployeeDetailScreen({Key? key}) : super(key: key);

  @override
  State<EmployeeDetailScreen> createState() => _EmployeeDetailScreenState();
}

class _EmployeeDetailScreenState extends State<EmployeeDetailScreen> {
  EmployeeModel get employeeModel => Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(employeeModel.name),
      ),
      body: GetBuilder(
        builder: (EmployeeDetailController controller) {
          if (controller.isLoading && controller.checkingDetail.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.uiFailure != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    getMessageFromErrorType(
                        controller.uiFailure!.type, controller.uiFailure!.code),
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                      onPressed: () {
                        controller.retry();
                      },
                      child: const Text("Retry"))
                ],
              ),
            );
          } else if (controller.checkingDetail.isEmpty) {
            return const Center(
              child: Text(
                "No result found",
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: controller.retry,
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: controller.checkingDetail.length,
              itemBuilder: (context, index) {
                final data = controller.checkingDetail[index];
                return GestureDetector(
                  onTap: () {
                    Get.toNamed(CheckingDetailScreen.routeName,
                        arguments: data);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border(
                            bottom: BorderSide(color: Colors.grey.shade300))),
                    margin: const EdgeInsets.all(5.0),
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        getTextHorizontally("Emplyee Id ", data.employeeId),
                        const SizedBox(height: 2),
                        getTextHorizontally("Checkin Id ", data.id),
                        const SizedBox(height: 2),
                        getTextVertically("Location:", data.location),
                        const SizedBox(height: 2),
                        getTextVertically("Purpose:", data.purpose),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget getTextHorizontally(String name, String text) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 2),
        Text(
          ": $text",
          style: const TextStyle(fontSize: 13),
        ),
        const SizedBox(height: 2),
      ],
    );
  }

  Widget getTextVertically(String title, String desc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 2),
        Text(desc),
      ],
    );
  }
}
