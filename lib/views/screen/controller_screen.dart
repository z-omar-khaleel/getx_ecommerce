import 'package:ecommerce_getx/controller/auth_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:delayed_display/delayed_display.dart';

import 'Home_screen.dart';
import 'login_screen.dart';

class ControllerScreen extends GetWidget<Auth> {
  @override
  Widget build(BuildContext context) {
    return ((controller.user != null))
        ? HomeScreen()
        : DelayedDisplay(
            child: LoginScreen(),
            delay: Duration(seconds: 2),
          );
  }
}
