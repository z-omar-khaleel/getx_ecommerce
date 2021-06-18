import 'package:ecommerce_getx/controller/services/sqlite_cart.dart';
import 'package:ecommerce_getx/model/cart_model.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  CartController() {
    getAllProduct();
  }
  List<CartModel> cartProduct = [];
  List<String> _allId = [];
  double totalPrice = 0.0;

  Future<CartModel> addProduct(CartModel model) async {
    _allId = [];
    await getAllProduct();
    print('cartProduct.length ${cartProduct.length}');
    cartProduct.forEach((element) {
      addId(element.id);
      print(element.id);
    });

    print('_allId.length ${_allId.length}');
    bool x = false;
    var modelAdded;
    var dbHelper = CartDatabaseHelper.cartHelper;
    if (cartProduct.length > 0) {
      for (int i = 0; i < _allId.length; ++i) {
        if (model.id == _allId[i]) {
          x = true;
          modelAdded =
              cartProduct.where((element) => element.id == model.id).first;

          break;
        } else {
          x = false;
        }
      }
    } else {
      _allId = [];
    }

    if (x) {
      modelAdded = CartModel(
          id: model.id,
          image: model.image,
          price: model.price,
          name: model.name,
          quantity: (++modelAdded.quantity));
      print('quantity =${modelAdded.quantity}');

      await updateCart(modelAdded);
    } else {
      print('else');
      modelAdded = await dbHelper.insert(model);
      print('quantity else =${modelAdded.quantity}');
      addId(modelAdded.id!);
    }

    update();
    return modelAdded;
  }

  addId(String id) async {
    if (!_allId.contains(id)) {
      _allId.add(id);
    }
  }

  getAllProduct() async {
    var dbHelper = CartDatabaseHelper.cartHelper;
    var x = await dbHelper.getAllProduct();
    cartProduct = x;
    totalPrice = cartProduct.fold(
        0.0, (sum, element) => sum + ((element.price * element.quantity)));
    print('cartProduct.length ${cartProduct.length}');
    print('x.length ${x.length}');
    update();
  }

  Future<void> updateCart(CartModel model) async {
    var dbHelper = CartDatabaseHelper.cartHelper;
    await dbHelper.updateProduct(model);
    await getAllProduct();
    update();
  }

  deleteCartObject(CartModel cart, {bool isConfirmed = false}) async {
    var dbHelper = CartDatabaseHelper.cartHelper;
    if (isConfirmed) {
      await dbHelper.delete(cart.id);
      await getAllProduct();
      return;
    }
    if (cart.quantity > 1) {
      print(cart.quantity);
      var newCart = CartModel(
          image: cart.image,
          price: cart.price,
          name: cart.name,
          id: cart.id,
          quantity: (--cart.quantity));
      await updateCart(newCart);
      print(newCart.quantity);
    } else {
      await dbHelper.delete(cart.id);
      await getAllProduct();
    }
  }

  deleteAll() async {
    var dbHelper = CartDatabaseHelper.cartHelper;
    await dbHelper.deleteAll();
    await getAllProduct();
  }
}
