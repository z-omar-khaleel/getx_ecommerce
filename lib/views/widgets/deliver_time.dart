import 'package:ecommerce_getx/controller/checkout_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custom_text.dart';

class DeliveryTime extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CheckoutController>(
      builder: (logic) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: RadioListTile<Delivery>(
                  value: Delivery.Standard,
                  groupValue: logic.delivery,
                  onChanged: (val) {
                    logic.changeDeliveryMethod(val!);
                  },
                  title: CustomText(
                    txt: 'Standard Delivery',
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontsize: 25,
                  ),
                  subtitle: Text(
                    ' Order will be delivered between 3 - 5 business days',
                    style: TextStyle(
                        color: Colors.black87, fontSize: 20, height: 1.5),
                    textDirection: TextDirection.ltr,
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: RadioListTile<Delivery>(
                  value: Delivery.NextDay,
                  groupValue: logic.delivery,
                  onChanged: (val) {
                    logic.changeDeliveryMethod(val!);
                  },
                  title: CustomText(
                    txt: 'Next Day Delivery',
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontsize: 25,
                  ),
                  subtitle: Text(
                    'Place your order before 6pm and your items will be delivered the next day',
                    style: TextStyle(
                        color: Colors.black87, fontSize: 20, height: 1.5),
                    textDirection: TextDirection.ltr,
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: RadioListTile<Delivery>(
                  value: Delivery.Nominated,
                  groupValue: logic.delivery,
                  onChanged: (val) {
                    logic.changeDeliveryMethod(val!);
                  },
                  title: CustomText(
                    txt: 'Nominated Delivery',
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontsize: 25,
                  ),
                  subtitle: Text(
                    ' Pick a particular date from the calendar and order will be delivered on selected date',
                    style: TextStyle(
                        color: Colors.black87, fontSize: 20, height: 1.5),
                    textDirection: TextDirection.ltr,
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        );
      },
    );
  }
}

enum Delivery { Standard, NextDay, Nominated }
