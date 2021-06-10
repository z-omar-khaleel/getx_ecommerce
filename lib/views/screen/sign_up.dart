import 'package:ecommerce_getx/controller/auth_controller.dart';
import 'package:ecommerce_getx/utils/components/custom_text.dart';
import 'package:ecommerce_getx/utils/components/custom_textfield.dart';
import 'package:ecommerce_getx/utils/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login_screen.dart';

class SignUp extends GetWidget<Auth> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);

    return WillPopScope(
      onWillPop: () async {
        Get.offAll(LoginScreen());
        return false;
      },
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(
              top: media.size.height * .10, left: 18, right: 18),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Form(
                  key: _key,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            txt: 'SignUp ,',
                            color: Colors.black,
                            fontsize: 25,
                          ),
                          TextButton(
                            child: CustomText(
                              txt: 'SignIn',
                              color: primartColor,
                              fontsize: 20,
                            ),
                            onPressed: () {
                              Get.offAll(LoginScreen());
                            },
                          )
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      CustomTextField(
                        isObscureText: false,
                        txt: 'Name',
                        hint: 'Enter Your Name',
                        onSaved: (val) {
                          controller.name.value = val!;
                        },
                        valdator: (val) {
                          if (val.toString().isEmpty)
                            return 'please enter Your Name';
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        txt: 'Email',
                        hint: 'Enter Your Email',
                        onSaved: (val) {
                          controller.email.value = val!;
                        },
                        valdator: (val) {
                          if (!GetUtils.isEmail(val))
                            return 'please enter correct email';
                          return null;
                        },
                        isObscureText: false,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        txt: 'Password',
                        hint: 'Enter Your Password',
                        onSaved: (val) {
                          controller.password.value = val!;
                        },
                        valdator: (val) {
                          if (val.length < 8)
                            return 'the password must be greather that eight character';
                          return null;
                        },
                        isObscureText: true,
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      SizedBox(
                        height: media.size.height * .04,
                      ),
                      TextButton(
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            backgroundColor: primartColor,
                            padding: EdgeInsets.all(10),
                          ),
                          onPressed: () {
                            _key.currentState!.save();
                            if (_key.currentState!.validate()) {
                              controller.signUpWithEmailAndPassword();
                            }
                          },
                          child: CustomText(
                            alignment: Alignment.center,
                            txt: 'SIGN UP',
                            color: Colors.white,
                          )),
                      SizedBox(
                        height: media.size.height * .06,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
