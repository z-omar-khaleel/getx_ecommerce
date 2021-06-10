import 'package:ecommerce_getx/controller/auth_controller.dart';
import 'package:ecommerce_getx/controller/cart_controller.dart';
import 'package:ecommerce_getx/controller/home_controller.dart';
import 'package:get/get.dart';

import '../hare_pref_controller.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => Auth());
    Get.lazyPut(() => HomeController());
    Get.put(CartController());
    Get.lazyPut(() => SharePrefController());
  }
}
