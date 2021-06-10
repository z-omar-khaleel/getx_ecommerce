import 'package:ecommerce_getx/controller/auth_controller.dart';
import 'package:ecommerce_getx/utils/constant/constant.dart';
import 'package:ecommerce_getx/views/screen/sign_up.dart';

import 'package:ecommerce_getx/utils/components/custom_text.dart';
import 'package:ecommerce_getx/utils/components/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'forget_password.dart';

class LoginScreen extends GetWidget<Auth> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    return Scaffold(
      body: Padding(
        padding:
            EdgeInsets.only(top: media.size.height * .10, left: 18, right: 18),
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
                          txt: 'Welcome ,',
                          color: Colors.black,
                          fontsize: 25,
                        ),
                        TextButton(
                          child: CustomText(
                            txt: 'SignUp',
                            color: primartColor,
                            fontsize: 20,
                          ),
                          onPressed: () {
                            Get.to(SignUp());
                          },
                        )
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    CustomText(
                      txt: 'Sign in to Continue',
                      fontsize: 15,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 30,
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
                    TextButton(
                        //not work
                        onPressed: () {
                          Get.to(ResetPassword());
                        },
                        child: CustomText(
                          alignment: Alignment.topRight,
                          txt: 'Forgot Password ?',
                          color: Colors.black,
                        )),
                    SizedBox(
                      height: media.size.height * .04,
                    ),
                    TextButton(
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7)),
                          backgroundColor: primartColor,
                          padding: EdgeInsets.all(10),
                        ),
                        onPressed: () {
                          _key.currentState!.save();
                          if (_key.currentState!.validate()) {
                            controller.signInWithEmailAndPassword();
                          }
                        },
                        child: CustomText(
                          alignment: Alignment.center,
                          txt: 'SIGN IN',
                          color: Colors.white,
                        )),
                    SizedBox(
                      height: media.size.height * .06,
                    ),
                    CustomText(
                      color: Colors.black,
                      txt: '-OR-',
                      fontsize: 20,
                      alignment: Alignment.center,
                    ),
                    SizedBox(
                      height: media.size.height * .07,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shadowColor: primartColor,
                        primary: Colors.white,
                      ),
                      child: ListTile(
                        leading: Image.asset('assets/images/Icon_Facebook.png'),
                        title: CustomText(
                          txt: 'Sign In with Facebook',
                          color: Colors.black,
                          fontsize: 15,
                          alignment: Alignment.center,
                        ),
                      ),
                      onPressed: () async {
                        await controller.signInWithFacebook();
                      },
                    ),
                    SizedBox(
                      height: media.size.height * .02,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shadowColor: primartColor,
                        primary: Colors.white,
                      ),
                      child: ListTile(
                        leading:
                            Image.asset('assets/images/icons8_Google_2.png'),
                        title: CustomText(
                          txt: 'Sign In with Google',
                          color: Colors.black,
                          fontsize: 15,
                          alignment: Alignment.center,
                        ),
                      ),
                      onPressed: () async {
                        await controller.signInWithGoogle();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
