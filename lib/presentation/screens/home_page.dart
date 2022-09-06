import 'package:flutter/material.dart';
import 'package:project_blackforest/presentation/screens/chat_page.dart';
import 'package:project_blackforest/presentation/widgets/nav_bar_icon.dart';

import 'contacts_page.dart';
import 'profile_page.dart';
import 'scanqr_page.dart';

// this is the common page for all pages and bottom navigation bar
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _pageController = PageController();

  int _currentIndex = 0;
  void _updatePage(int index) {
    setState(() {
      _pageController.jumpToPage(index);
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedFontSize: 0,
        onTap: _updatePage,
        items: buildNavBarList([
          Icons.mark_chat_unread,
          Icons.person,
          Icons.add_a_photo,
        ]),
      ),
      body: PageView(
        onPageChanged: _updatePage,
        controller: _pageController,
        children: const [
          ContactPage(),
          ProfilePage(),
          ScanqrPage(),
        ],
      ),
    );
  }
}
