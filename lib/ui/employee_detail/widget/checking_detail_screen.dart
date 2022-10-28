import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/core/const/app_settings.dart';
import 'package:task/ui/employee_detail/model/checkin_detail_model.dart';

class CheckingDetailScreen extends StatefulWidget {
  static const String routeName = "/checking-detail-screen";
  const CheckingDetailScreen({Key? key}) : super(key: key);

  @override
  State<CheckingDetailScreen> createState() => _CheckingDetailScreenState();
}

class _CheckingDetailScreenState extends State<CheckingDetailScreen> {
  CheckingDetailModel get checkingDetailModel => Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Checkin Id ${checkingDetailModel.id}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getTextHorizontally("Emplyee Id ", checkingDetailModel.employeeId),
            const SizedBox(height: 2),
            getTextHorizontally("Checkin Id ", checkingDetailModel.id),
            const SizedBox(height: 2),
            getTextVertically("Location:", checkingDetailModel.location),
            const SizedBox(height: 2),
            getTextVertically("Purpose:", checkingDetailModel.purpose),
          ],
        ),
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
