import 'dart:convert';

import 'package:ecommerce_getx/controller/hare_pref_controller.dart';
import 'package:ecommerce_getx/controller/home_controller.dart';
import 'package:ecommerce_getx/model/user_info.dart';
import 'package:ecommerce_getx/utils/constant/constant.dart';
import 'package:ecommerce_getx/views/widgets/account_screen.dart';
import 'package:ecommerce_getx/views/widgets/cart_screen.dart';
import 'package:ecommerce_getx/views/widgets/explore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  final control = Get.find<SharePrefController>();

  late List<Widget> _children;
  @override
  Widget build(BuildContext context) {
    if (currentUser == null) {
      control
          .getDataPref(key: 'uid')
          .then((value) => currentUser = UserInfor.fromJson(jsonDecode(value)));
    }
    _children = [Explore(), CartScreen(), AccountScreen()];
    return Scaffold(
        bottomNavigationBar: bottomNavigation(),
        body: GetBuilder<HomeController>(builder: (c) => _children[c.index]));
  }

  Widget bottomNavigation() {
    return GetBuilder<HomeController>(
      builder: (c) => BottomNavigationBar(
        selectedFontSize: 22,
        selectedItemColor: primartColor,
        selectedIconTheme: IconThemeData(color: primartColor),
        currentIndex: c.index,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              activeIcon: Text(
                'Explore',
                style: TextStyle(color: primartColor, fontSize: 17),
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_rounded),
              activeIcon: Text(
                'Cart',
                style: TextStyle(color: primartColor, fontSize: 17),
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box_rounded),
              activeIcon: Text(
                'Account',
                style: TextStyle(color: primartColor, fontSize: 17),
              ),
              label: ''),
        ],
        onTap: (i) {
          c.updateIndex(i);
          print(c.index.toString());
        },
      ),
    );
  }
}
