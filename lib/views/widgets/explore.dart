import 'package:ecommerce_getx/controller/home_controller.dart';
import 'package:ecommerce_getx/utils/constant/constant.dart';

import 'package:ecommerce_getx/views/screen/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/components/custom_text.dart';

class Explore extends StatelessWidget {
  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    if (controller.bestSelling.length == 0 ||
        controller.categories.length == 0) {
      controller.getCategries().then((value) => print(value));
      controller.getBestSelling().then((value) => null);
    }

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(top: Get.height * .11, left: 20, right: 20),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20)),
              child: TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            SizedBox(
              height: Get.height * .04,
            ),
            CustomText(
              txt: 'Categories',
              color: Colors.black,
              fontsize: 30,
            ),
            SizedBox(
              height: Get.height * .04,
            ),
            GetBuilder<HomeController>(builder: (cont) {
              return Container(
                height: Get.height * .22,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (c, i) {
                      return Column(
                        children: [
                          CircleAvatar(
                            child: Image.network(
                              cont.categories[i].pic,
                              fit: BoxFit.cover,
                            ),
                            backgroundColor: Colors.grey.shade200,
                            radius: 40,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomText(
                            txt: cont.categories[i].name,
                            fontsize: 20,
                            color: Colors.black54,
                          )
                        ],
                      );
                    },
                    separatorBuilder: (context, i) {
                      return SizedBox(
                        width: Get.width * .10,
                      );
                    },
                    itemCount: cont.categories.length),
              );
            }),
            SizedBox(
              height: Get.height * .04,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  txt: 'Best Selling',
                  fontsize: 20,
                  color: Colors.black,
                ),
                CustomText(
                  txt: 'see all ',
                  fontsize: 20,
                  color: Colors.grey.shade700,
                ),
              ],
            ),
            SizedBox(
              height: Get.height * .04,
            ),
            GetBuilder<HomeController>(builder: (control) {
              return Container(
                height: Get.height * .35,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (c, i) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(DetailsScreen(
                            bestSelling: control.bestSelling[i],
                          ));
                        },
                        child: Column(
                          children: [
                            Container(
                              height: Get.height * .19,
                              child: Image.network(
                                control.bestSelling[i].pic,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            CustomText(
                              txt: control.bestSelling[i].title,
                              color: Colors.black,
                              fontsize: 22,
                              alignment: Alignment.bottomLeft,
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            CustomText(
                              txt: control.bestSelling[i].subTitle
                                  .substring(0, 3),
                              color: Colors.grey,
                              fontsize: 18,
                              alignment: Alignment.bottomLeft,
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            CustomText(
                              txt: '\$${control.bestSelling[i].price}',
                              fontsize: 18,
                              color: primartColor,
                              alignment: Alignment.topRight,
                            )
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (c, i) {
                      return SizedBox(
                        width: 20,
                      );
                    },
                    itemCount: control.bestSelling.length),
              );
            })
          ],
        ),
      ),
    );
  }
}
