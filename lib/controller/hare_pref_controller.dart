import 'package:ecommerce_getx/controller/services/shared_prf.dart';
import 'package:ecommerce_getx/views/screen/login_screen.dart';

import 'package:get/get.dart';

class SharePrefController extends GetxController {
  var homeWidget = true.obs;
  Future<bool> setDataPref({required String key, dynamic data}) async {
    var x = await SharePref.setData(key: key, data: data);
    update();
    return x;
  }

  Future<dynamic> getDataPref({required String key}) async {
    var x = await SharePref.getData(key: key);
    update();
    return x;
  }

  Future<bool> removeKey(String key) async {
    var x = await SharePref.removeKey(key);
    homeWidget.value = false;
    Get.offAll(LoginScreen());
    return x;
  }
}
