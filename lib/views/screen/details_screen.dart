import 'package:ecommerce_getx/controller/cart_controller.dart';
import 'package:ecommerce_getx/model/best.dart';
import 'package:ecommerce_getx/model/cart_model.dart';
import 'package:ecommerce_getx/utils/components/custom_text.dart';
import 'package:ecommerce_getx/utils/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Home_screen.dart';

// ignore: must_be_immutable
class DetailsScreen extends StatelessWidget {
  BestSelling bestSelling;
  var x = 5;
  DetailsScreen({required this.bestSelling});

  @override
  Widget build(BuildContext context) {
    x = ++x;
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: Get.width,
            height: Get.height * .25,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(bestSelling.pic), fit: BoxFit.fill)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Get.off(() => HomeScreen());
                    },
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(
                    icon: Icon(Icons.star_border),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 7,
                  ),
                  CustomText(
                    txt: bestSelling.title,
                    fontsize: 32,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        height: 60,
                        width: Get.width * .40,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(20),
                            shape: BoxShape.rectangle),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Size',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 20)),
                              Text('xl',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        height: 60,
                        width: Get.width * .40,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(20),
                            shape: BoxShape.rectangle),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Color',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 20)),
                              Container(
                                width: 25,
                                height: 25,
                                color: Colors.blue,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  CustomText(
                    txt: 'Details',
                    fontsize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  SingleChildScrollView(
                    child: Container(
                      height: Get.height * .35,
                      child: Text(
                        bestSelling.title,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  Expanded(
                      child: Container(
                    width: Get.width,
                    color: Colors.grey.withOpacity(.1),
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Price :',
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                bestSelling.price.toString() + ' \$',
                                style: TextStyle(
                                    fontSize: 15, color: primartColor),
                              ),
                            ],
                          ),
                          GetBuilder<CartController>(
                            init: Get.put(CartController()),
                            builder: (controller) => ElevatedButton(
                              onPressed: () async {
                                var model = await controller.addProduct(
                                    CartModel(
                                        image: bestSelling.pic,
                                        price: bestSelling.price,
                                        name: bestSelling.title,
                                        quantity: 1,
                                        id: bestSelling.id));
                              },
                              style: ElevatedButton.styleFrom(
                                primary: primartColor,
                              ),
                              child: Text(
                                'ADD',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
