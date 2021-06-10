import 'package:ecommerce_getx/controller/cart_controller.dart';
import 'package:ecommerce_getx/controller/checkout_controller.dart';
import 'package:ecommerce_getx/utils/components/custom_text.dart';
import 'package:ecommerce_getx/utils/constant/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Summary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            GetBuilder<CartController>(
              builder: (logic) {
                return Container(
                  height: 140,
                  width: Get.width,
                  child: ListView.separated(
                    itemBuilder: (c, index) => Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 80,
                          width: 120,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      logic.cartProduct[index].image),
                                  fit: BoxFit.fill)),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        CustomText(
                          txt: logic.cartProduct[index].name.toString(),
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontsize: 17,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '\$ ' + logic.cartProduct[index].price.toString(),
                          style: TextStyle(
                            color: primartColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.start,
                        )
                      ],
                    ),
                    separatorBuilder: (c, index) => Padding(
                      padding: EdgeInsets.all(8),
                    ),
                    itemCount: logic.cartProduct.length,
                    scrollDirection: Axis.horizontal,
                  ),
                );
              },
            ),
            SizedBox(
              height: Get.height * .06,
            ),
            Divider(
              color: Colors.grey,
              height: 1,
            ),
            SizedBox(
              height: 30,
            ),
            CustomText(
              txt: 'Shipping Address',
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontsize: 24,
            ),
            SizedBox(
              height: 7,
            ),
            GetBuilder<CheckoutController>(
              builder: (logic) {
                return Text(
                  '${logic.addressInfo!.street1} , ${logic.addressInfo!.street2} , ${logic.addressInfo!.country} , ${logic.addressInfo!.city} ,${logic.addressInfo!.state}',
                  style: TextStyle(
                    fontSize: 19,
                    color: Colors.black87,
                  ),
                );
              },
            ),
            SizedBox(
              height: 40,
            ),
            Divider(
              height: 1,
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}
