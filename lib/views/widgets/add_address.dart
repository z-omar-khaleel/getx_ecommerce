import 'package:ecommerce_getx/controller/checkout_controller.dart';
import 'package:ecommerce_getx/utils/components/custom_text.dart';
import 'package:ecommerce_getx/utils/components/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class AddAddress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CheckoutController>(
      builder: (controller) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 30,
              ),
              Directionality(
                textDirection: TextDirection.ltr,
                child: CheckboxListTile(
                  value: controller.isSameBiling,
                  onChanged: (val) {
                    controller.changeIsSameBiling(val!);
                  },
                  title: CustomText(
                    txt: 'Billing address is the same as delivery address',
                    color: Colors.black87,
                    fontsize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Form(
                key: controller.addressKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: CustomTextField(
                          intinalVal: controller.addressInfo?.street1 ?? '',
                          txt: 'Street 1',
                          hint: null,
                          onSaved: (val) {
                            controller.changeStreet1(val!);
                          },
                          valdator: (val) {
                            if (val == null || val.isEmpty)
                              return 'required Text';
                            return null;
                          },
                          isObscureText: false),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: CustomTextField(
                          intinalVal: controller.addressInfo?.street2 ?? '',
                          txt: 'Street 2',
                          hint: 'Opposite Omegatron, Vicent Quarters',
                          onSaved: (val) {
                            controller.changeStreet2(val!);
                          },
                          valdator: (val) {
                            return null;
                          },
                          isObscureText: false),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: CustomTextField(
                          intinalVal: controller.addressInfo?.city ?? '',
                          txt: 'City',
                          hint: 'Victoria Island',
                          onSaved: (val) {
                            controller.changeCity(val ?? '');
                          },
                          valdator: (val) {
                            if (val == null || val.isEmpty)
                              return 'required Text';
                            return null;
                          },
                          isObscureText: false),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                                intinalVal: controller.addressInfo?.state ?? '',
                                txt: 'State',
                                hint: 'Lagos State',
                                onSaved: (val) {
                                  controller.changeState(val!);
                                },
                                valdator: (val) {
                                  if (val == null || val.isEmpty)
                                    return 'required Text';
                                  return null;
                                },
                                isObscureText: false),
                          ),
                          Expanded(
                            child: CustomTextField(
                                intinalVal:
                                    controller.addressInfo?.country ?? '',
                                txt: 'Country',
                                hint: 'Nigeria',
                                onSaved: (val) {
                                  controller.changeCountry(val!);
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                },
                                valdator: (val) {
                                  if (val == null || val.isEmpty)
                                    return 'required Text';
                                  return null;
                                },
                                isObscureText: false),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
