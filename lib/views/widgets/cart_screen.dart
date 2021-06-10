import 'package:ecommerce_getx/controller/cart_controller.dart';
import 'package:ecommerce_getx/controller/checkout_controller.dart';
import 'package:ecommerce_getx/model/cart_model.dart';
import 'package:ecommerce_getx/utils/components/custom_text.dart';
import 'package:ecommerce_getx/utils/constant/constant.dart';
import 'package:ecommerce_getx/views/screen/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GetBuilder<CartController>(
        init: Get.find<CartController>(),
        builder: (controller) => controller.cartProduct.length == 0
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    child: SvgPicture.asset(
                        'assets/images/undraw_empty_cart_co35.svg'),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomText(
                    txt: 'Empty Cart',
                    alignment: Alignment.center,
                    fontsize: 22,
                    fontWeight: FontWeight.bold,
                  )
                ],
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (c, i) => buildCartItem(
                            controller.cartProduct[i], controller, context),
                        separatorBuilder: (c, i) =>
                            Padding(padding: EdgeInsets.all(12)),
                        itemCount: controller.cartProduct.length),
                  ),
                  Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            CustomText(
                              txt: 'Total',
                              color: Colors.grey[350]!,
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            CustomText(txt: ' ${controller.totalPrice} \$')
                          ],
                        ),
                        Container(
                          height: 45,
                          width: 140,
                          child: ElevatedButton(
                            onPressed: () {
                              Get.to(
                                () => IconStepperDemo(),
                                binding: BindingsBuilder(() {
                                  Get.lazyPut<CheckoutController>(() =>
                                      CheckoutController()..getAddressInfo());
                                }),
                              );
                            },
                            child: CustomText(
                              txt: 'Checkout',
                              alignment: Alignment.center,
                              color: Colors.white,
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: primartColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }

  Future<bool?> confirmDialog(context, model, controller) async {
    return await showDialog<bool>(
      context: context,

      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Item'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text('Are You sure you want to delete quantities'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Confirm'),
              onPressed: () {
                controller.deleteCart(model, isConfirmed: true);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
          ],
        );
      },
    );
  }

  buildCartItem(CartModel model, CartController controller, context) {
    return Dismissible(
      confirmDismiss: (dir) async {
        return confirmDialog(context, model, controller);
      },
      direction: DismissDirection.endToStart,
      key: ValueKey(model.id),
      background: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            padding: const EdgeInsets.symmetric(horizontal: 100.0),
            icon: Icon(
              Icons.delete,
              size: 50,
              color: Colors.white,
            ),
            onPressed: () async {
              confirmDialog(context, model, controller);
            },
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 120,
          width: double.infinity,
          child: Row(
            children: [
              Container(
                width: 120,
                height: 120,
                child: Image(
                  image: NetworkImage(model.image),
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    txt: model.name,
                    color: Colors.black,
                    fontsize: 20,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CustomText(
                    txt: '\$ ${model.price}',
                    color: primartColor,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 40,
                    width: 120,
                    color: Colors.grey[400],
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () async {
                              await controller.addProduct(model);
                            },
                            icon: Icon(Icons.add)),
                        Text(model.quantity.toString()),
                        IconButton(
                          padding: EdgeInsets.only(bottom: 20),
                          onPressed: () async {
                            await controller.deleteCart(model);
                          },
                          icon: Icon(Icons.minimize),
                        ),
                      ],
                    ),
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
