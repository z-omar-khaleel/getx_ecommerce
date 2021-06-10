import 'dart:convert';

import 'package:ecommerce_getx/controller/helper/binding.dart';
import 'package:ecommerce_getx/model/user_info.dart';
import 'package:ecommerce_getx/utils/constant/constant.dart';
import 'package:ecommerce_getx/views/screen/Home_screen.dart';
import 'package:ecommerce_getx/views/screen/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'controller/hare_pref_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black.withOpacity(.2),
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark));
  final control = Get.put(SharePrefController());

  currentUser = await control.getDataPref(key: 'uid') == null
      ? null
      : UserInfor.fromJson(jsonDecode(await control.getDataPref(key: 'uid')));
  if (currentUser != null) {
    control.homeWidget.value = true;
  } else {
    control.homeWidget.value = false;
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp();

  @override
  Widget build(BuildContext context) {
    return GetX<SharePrefController>(
      builder: (c) => GetMaterialApp(
        smartManagement:
            SmartManagement.keepFactory, // or .keepFactory or .onlyBuilder

        debugShowCheckedModeBanner: false,
        initialBinding: Binding(),
        home: c.homeWidget.value ? HomeScreen() : LoginScreen(),
      ),
    );
  }
}
