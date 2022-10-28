import 'package:flutter/material.dart';
import 'package:task/ui/home/home_tab.dart';
import 'package:task/ui/profile/profile_tab.dart';

class BaseScreen extends StatefulWidget {
  static const String routeName = "/home-screen";
  const BaseScreen({Key? key}) : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  PageController pageController = PageController();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: const [HomeTab(), ProfileTab()],
      ),
      bottomNavigationBar: BottomAppBar(
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (val) {
            pageController.jumpToPage(val);
            currentIndex = val;
            setState(() {});
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
      ),
    );
  }
}
