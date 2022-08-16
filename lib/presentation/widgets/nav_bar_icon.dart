import 'package:flutter/material.dart';

import '../../constants/colors.dart';

List<BottomNavigationBarItem> buildNavBarList(List<IconData> itemList) {
  List<BottomNavigationBarItem> navBarItemList = [];
  itemList.forEach(
    (element) {
      navBarItemList.add(
        BottomNavigationBarItem(
          label: '•',
          icon: Icon(
            element,
            color: inactiveColor,
          ),
          activeIcon: Icon(
            element,
            color: primaryColor,
          ),
        ),
      );
    },
  );
  return navBarItemList;
}
