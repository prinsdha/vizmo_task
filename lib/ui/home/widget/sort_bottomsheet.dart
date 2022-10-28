import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/core/const/app_settings.dart';
import 'package:task/ui/home/controller/home_controller.dart';

enum SortBy { ascending, descending }

enum FilterBy { none, id, name }

Future<ApiFilter?> showSortAndFilterBottomSheet(
    {required ApiFilter apiFilter}) async {
  ApiFilter? filter;
  await Get.bottomSheet(
      _SortAndFilterBottomSheet(
          onChange: (f) {
            filter = f;
          },
          apiFilter: apiFilter),
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(
              left: Radius.circular(15), right: Radius.circular(15))));
  return filter;
}

class _SortAndFilterBottomSheet extends StatefulWidget {
  final ApiFilter apiFilter;
  final Function(ApiFilter) onChange;
  const _SortAndFilterBottomSheet(
      {Key? key, required this.onChange, required this.apiFilter})
      : super(key: key);

  @override
  State<_SortAndFilterBottomSheet> createState() =>
      _SortAndFilterBottomSheetState();
}

class _SortAndFilterBottomSheetState extends State<_SortAndFilterBottomSheet> {
  late ApiFilter apiFilter;

  @override
  void initState() {
    apiFilter = widget.apiFilter;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        header("Filter By"),
        ...FilterBy.values
            .map(
              (e) => ListTile(
                  title: Text(e.name.capitalizeFirst ?? ""),
                  onTap: () {
                    apiFilter.filterBy = e;
                    setState(() {});
                  },
                  trailing: e == apiFilter.filterBy
                      ? const Icon(
                          Icons.done,
                          color: Colors.black,
                        )
                      : null),
            )
            .toList(),
        apiFilter.filterBy == FilterBy.none ? const SizedBox() : header("Sort By"),
        ...apiFilter.filterBy == FilterBy.none
            ? []
            : SortBy.values
                .map(
                  (e) => ListTile(
                      onTap: () {
                        apiFilter.sortBy = e;
                        setState(() {});
                      },
                      title: Text(e.name.capitalizeFirst ?? ""),
                      trailing: e == apiFilter.sortBy
                          ? const Icon(
                              Icons.done,
                              color: Colors.black,
                            )
                          : null),
                )
                .toList(),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  widget.onChange(ApiFilter(
                      sortBy: SortBy.ascending, filterBy: FilterBy.none));
                  Get.back();
                },
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: const Center(
                    child: Text(
                      "Clear Filter",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  widget.onChange(apiFilter);
                  Get.back();
                },
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: const Center(
                    child: Text(
                      "Apply Filter",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget header(String text) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(vertical: 18, horizontal: kDefaultPadding),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
      ),
    );
  }
}
