import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_getx/model/address_model.dart';
import 'package:ecommerce_getx/utils/constant/constant.dart';
import 'package:ecommerce_getx/views/widgets/add_address.dart';
import 'package:ecommerce_getx/views/widgets/deliver_time.dart';
import 'package:ecommerce_getx/views/widgets/summary.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CheckoutController extends GetxController {
  final addressKey = GlobalKey<FormState>();
  int activeStep = 0;
  var delivery = Delivery.Standard;
  bool isSameBiling = false;
  AddressModelInfo? addressInfo;
  String street1 = '', street2 = '', city = '', state = '', country = '';
  changeIsSameBiling(bool val) {
    isSameBiling = val;
    update();
  }

  List<Widget> children = [DeliveryTime(), AddAddress(), Summary()];
  updateActiveStep(int step) {
    this.activeStep = step;
    print(activeStep);
    update();
  }

  changeDeliveryMethod(Delivery val) {
    delivery = val;
    update();
  }

  changeStreet1(String val) {
    street1 = val;
    update();
  }

  changeStreet2(String val) {
    street2 = val;
    update();
    print(val);
  }

  changeState(String val) {
    state = val;
    update();
  }

  changeCountry(String val) {
    country = val;
    update();
  }

  changeCity(String val) {
    city = val;
    update();
  }

  saveAddreesInFire(AddressModelInfo model) async {
    await FirebaseFirestore.instance
        .collection('AddressInfo')
        .doc(currentUser?.uid)
        .set(model.toMap());
  }

  getAddressInfo() async {
    await FirebaseFirestore.instance
        .collection('AddressInfo')
        .doc(currentUser?.uid)
        .get()
        .then((value) => addressInfo = AddressModelInfo.fromMap(value.data()!));
    changeIsSameBiling(addressInfo?.isSameDelivery ?? false);
  }
}
