import 'dart:convert';

import 'package:ecommerce_getx/controller/hare_pref_controller.dart';
import 'package:ecommerce_getx/controller/services/firestore_add.dart';
import 'package:ecommerce_getx/model/user_info.dart';
import 'package:ecommerce_getx/views/screen/Home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';

class Auth extends GetxController {
  var email = ''.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Rx<User?> _user = Rx<User?>(FirebaseAuth.instance.currentUser);
  String? get user => _user.value == null ? null : _user.value!.email;

  @override
  void onInit() {
    // TODO: implement onInit
    _user.bindStream(_auth.authStateChanges());
    super.onInit();
  }

  var password = ''.obs;
  var name = ''.obs;
  Future<UserCredential?> signInWithGoogle() async {
    // Trigger the authentication flow

    final GoogleSignInAccount googleUser = (await GoogleSignIn().signIn())!;

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    try {
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      saveFire(userCredential);

      print(userCredential);
      Get.offAll(() => HomeScreen());

      return userCredential;
      // ignore: unused_catch_clause
    } on Exception catch (e) {
      // TODO
      Get.defaultDialog(
          title: "Enter correct information",
          middleText: 'Enter valid data',
          backgroundColor: Colors.red);
    }
  }

  Future<void> signInWithFacebook() async {
    // Trigger the sign-in flow
    final accessToken = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(accessToken.accessToken!.token);

    // Once signed in, return the UserCredential
    try {
      await _auth
          .signInWithCredential(facebookAuthCredential)
          .then((value) => saveFire(value));
      Get.offAll(HomeScreen());
    } on Exception catch (e) {
      print(e);
      Get.defaultDialog(
          title: "Enter correct information",
          middleText: 'Either password or email not valid or both',
          backgroundColor: Colors.green);
    }
  }

  signInWithEmailAndPassword() async {
    try {
      print(email);
      await _auth.signInWithEmailAndPassword(
          email: email.value, password: password.value);
      Get.offAll(HomeScreen());
      // ignore: unused_catch_clause
    } on Exception catch (e) {
      Get.defaultDialog(
          title: "Enter correct information",
          middleText: 'Either password or email not valid or both',
          backgroundColor: Colors.red);
    }
  }

  signUpWithEmailAndPassword() async {
    await _auth
        .createUserWithEmailAndPassword(
            email: email.value, password: password.value)
        .then((value) => saveFire(value));
    Get.offAll(HomeScreen());
  }

  Future<void> saveFire(UserCredential user) async {
    final addUser = FirestoreAdd();
    var model = UserInfor(
        email: user.user!.email,
        name: user.user!.displayName ?? name.value,
        pic: '',
        uid: user.user!.uid);
    final control = Get.put(SharePrefController());
    control.setDataPref(key: 'uid', data: jsonEncode(model.toJson()));
    await addUser.addToFire(info: model);
  }

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      // ignore: unused_catch_clause
    } on Exception catch (e) {
      throw Exception();
    }
  }
}
