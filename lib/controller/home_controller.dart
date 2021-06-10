import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_getx/model/best.dart';
import 'package:ecommerce_getx/model/categories.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  int index = 0;
  var isLoading = true.obs;
  List<Categories> categories = [];
  List<BestSelling> bestSelling = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  updateIndex(int i) {
    index = i;
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    print('==2=2=2=2=2=2');
  }

  Future<List<Categories>> getCategries() async {
    await _firestore.collection('categories').get().then((value) {
      value.docs.forEach((element) {
        categories.add(Categories.fromJson(element.data()));
      });
    });
    isLoading.value = false;

    update();
    return categories;
  }

  Future<void> getBestSelling() async {
    bestSelling = [];
    int count = 0;
    final value = await _firestore.collection('BestSelling').get();
    value.docs.forEach((element) {
      bestSelling.add(BestSelling.fromJson(element.data()));
      ++count;
      print(count);
    });
    isLoading.value = false;
    print('bestSelling.length ${bestSelling.length}');
    update();
  }
}
