import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task/core/network/utils/base_response.dart';
import 'package:task/ui/employee_detail/employee_detail_screen.dart';
import 'package:task/ui/search/controller/search_controller.dart';
import 'package:task/ui/search/widget/custom_textfield.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = "/search-screen";

  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController country = TextEditingController();

  SearchController get searchController => Get.find<SearchController>();
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent / 2 &&
          !scrollController.position.outOfRange) {
        searchController.fetchPage();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 90,
          titleSpacing: 0,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.close),
          ),
          title: Column(
            children: [
              const SizedBox(height: 5),
              CustomTextField(
                textFieldType: TextFieldType.name,
                textEditingController: name,
              ),
              const SizedBox(height: 5),
              CustomTextField(
                textFieldType: TextFieldType.country,
                textEditingController: country,
              ),
              const SizedBox(height: 5),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () {
                  if (country.text.trim().isEmpty && name.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Both Field can not be empty...")));
                  } else {
                    FocusManager.instance.primaryFocus!.unfocus();

                    searchController.searchEmployee(
                        country.text.trim(), name.text.trim());
                  }
                },
                child: const Text("Search")),
            const SizedBox(
              width: 5,
            )
          ],
        ),
        body: GetBuilder(
          builder: (SearchController controller) {
            if (controller.isLoading &&
                controller.searchedEmployeeList.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            } else if (controller.uiFailure != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      getMessageFromErrorType(controller.uiFailure!.type,
                          controller.uiFailure!.code),
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
            } else if (controller.searchedEmployeeList.isEmpty) {
              return const Center(
                child: Text(
                  "No result found",
                  style: TextStyle(fontSize: 16),
                ),
              );
            }

            return ListView.builder(
              controller: scrollController,
              itemCount: controller.searchedEmployeeList.length,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(top: 10),
              itemBuilder: (context, index) {
                final item = controller.searchedEmployeeList[index];
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(EmployeeDetailScreen.routeName,
                            arguments: item);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border(
                                bottom:
                                    BorderSide(color: Colors.grey.shade300))),
                        margin: const EdgeInsets.all(5.0),
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                                radius: 23,
                                backgroundImage: NetworkImage(item.avatar)),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                getText(
                                    "BirthDate",
                                    DateFormat("dd/MM/yyyy")
                                        .format(item.birthday)),
                                getText("Email", item.email),
                                getText("Phone", item.phone),
                                getText("Country", item.country),
                                getText(
                                    "Created At",
                                    DateFormat("dd/MM/yyyy")
                                        .format(item.createdAt)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    controller.isLoading &&
                            index ==
                                (controller.searchedEmployeeList.length - 1) &&
                            !controller.page.isNegative &&
                            controller.searchedEmployeeList.isNotEmpty
                        ? const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(child: CircularProgressIndicator()),
                          )
                        : const SizedBox()
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget getText(String name, String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 1.0),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          Text(
            ": $text",
            style: const TextStyle(fontSize: 13),
          ),
        ],
      ),
    );
  }
}
