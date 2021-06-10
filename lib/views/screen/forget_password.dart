import 'package:ecommerce_getx/controller/auth_controller.dart';
import 'package:ecommerce_getx/utils/components/custom_text.dart';
import 'package:ecommerce_getx/utils/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login_screen.dart';

class ResetPassword extends GetWidget<Auth> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAll(LoginScreen());
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('ForgetPassword'),
        ),
        body: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: _key,
                child: TextFormField(
                  decoration: InputDecoration(hintText: 'Enter Your Email'),
                  onSaved: (val) {
                    controller.email.value = val!;
                  },
                  validator: (val) {
                    if (!GetUtils.isEmail(val!))
                      return 'please enter correct email';
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 50,
              ),
              TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    primary: primartColor,
                    padding: EdgeInsets.all(20),
                  ),
                  onPressed: () async {
                    _key.currentState!.save();
                    if (_key.currentState!.validate()) {
                      if (controller.email.value.isNotEmpty) {
                        try {
                          await controller
                              .resetPassword(controller.email.value);
                          Get.offAll(LoginScreen());
                          // ignore: unused_catch_clause
                        } on Exception catch (e) {
                          Get.defaultDialog(
                              title: 'Enter Valid Email',
                              middleText: 'Enter Your Email');
                          print('zeco');
                        }
                      }
                    }
                  },
                  child: CustomText(
                    alignment: Alignment.center,
                    txt: 'OK',
                    color: Colors.white,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
