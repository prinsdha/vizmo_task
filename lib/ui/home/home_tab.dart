import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:task/ui/employee_detail/employee_detail_screen.dart';
import 'package:task/ui/home/controller/home_controller.dart';
import 'package:task/ui/home/model/employee_model.dart';
import 'package:task/ui/home/widget/sort_bottomsheet.dart';
import 'package:task/ui/search/search_screen.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with AutomaticKeepAliveClientMixin {
  HomeController get homeController => Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Employee"),
        actions: [
          IconButton(
              onPressed: () {
                Get.toNamed(SearchScreen.routeName);
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: GetBuilder(
        builder: (HomeController controller) {
          return RefreshIndicator(
            onRefresh: () async {
              controller.pagingController.refresh();
            },
            child: PagedListView<int, EmployeeModel>(
              pagingController: controller.pagingController,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(top: 10),
              builderDelegate: PagedChildBuilderDelegate<EmployeeModel>(
                itemBuilder: (context, item, index) => GestureDetector(
                  onTap: () {
                    Get.toNamed(EmployeeDetailScreen.routeName,
                        arguments: item);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border(
                            bottom: BorderSide(color: Colors.grey.shade300))),
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
                            getText("BirthDate",
                                DateFormat("dd/MM/yyyy").format(item.birthday)),
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
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showSortAndFilterBottomSheet(
              apiFilter: homeController.apiFilter,
            ).then((value) {
              if (value != null) {
                homeController.apiFilter = value;
              }
            });
          },
          child: const Icon(Icons.filter_alt_rounded)),
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

  @override
  bool get wantKeepAlive => true;
}
