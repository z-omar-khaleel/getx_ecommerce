import 'package:ecommerce_getx/controller/checkout_controller.dart';
import 'package:ecommerce_getx/model/address_model.dart';
import 'package:ecommerce_getx/utils/components/custom_text.dart';
import 'package:ecommerce_getx/utils/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im_stepper/stepper.dart';

// ignore: must_be_immutable
class IconStepperDemo extends GetView<CheckoutController> {
  // THE FOLLOWING TWO VARIABLES ARE REQUIRED TO CONTROL THE STEPPER.

  int upperBound = 2; // upperBound MUST BE total number of icons minus 1.
  int activeStep = 0;
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      builder: (c) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black.withOpacity(.6),
            ),
            onPressed: () {
              Get.back();
            },
          ),
          titleSpacing: 0,
          title: Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: CustomText(
              txt: headerText(),
              color: Colors.black.withOpacity(.6),
              alignment: Alignment.center,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Stack(
                children: [
                  IconStepper(
                    lineLength: Get.width / 3 - 20,
                    lineDotRadius: 3,
                    enableNextPreviousButtons: false,
                    icons: [
                      Icon(
                        Icons.circle,
                        color: controller.activeStep == 0
                            ? primartColor
                            : Colors.white,
                      ),
                      Icon(
                        Icons.circle,
                        color: controller.activeStep == 1
                            ? primartColor
                            : Colors.white,
                      ),
                      Icon(
                        Icons.circle,
                        color: controller.activeStep == 2
                            ? primartColor
                            : Colors.white,
                      ),
                    ],
                    stepColor: Colors.teal.withOpacity(.1), stepPadding: 5,
                    lineColor: controller.activeStep == 0
                        ? Colors.grey.withOpacity(.6)
                        : primartColor,
                    scrollingDisabled: true,
                    activeStepBorderWidth: 2,
                    stepRadius: 18,
                    activeStepBorderPadding: 1,
                    onStepReached: (index) {
                      controller.updateActiveStep(index);
                    },

                    // activeStep property set to activeStep variable defined above.
                    activeStep: controller.activeStep,
                    activeStepBorderColor: primartColor,
                    activeStepColor: Colors.white,

                    // This ensures step-tapping updates the activeStep.
                  ),
                  if (controller.activeStep >= 1)
                    Padding(
                      padding: EdgeInsets.only(left: Get.width * .16, top: 25),
                      child: Container(
                        color: primartColor,
                        width: Get.width / 3 - 30,
                        height: 10,
                      ),
                    ),
                  if (controller.activeStep == 2)
                    Padding(
                      padding: EdgeInsets.only(left: Get.width * .5, top: 25),
                      child: Container(
                        color: primartColor,
                        width: Get.width / 3 - 30,
                        height: 10,
                      ),
                    ),
                ],
              ),
              Expanded(child: controller.children[controller.activeStep]),
              Row(
                mainAxisAlignment: controller.activeStep == 0
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.center,
                children: [
                  controller.activeStep == 0 ? Container() : previousButton(),
                  SizedBox(
                    width: 20,
                  ),
                  nextButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Returns the next button.
  Widget nextButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: primartColor,
      ),
      onPressed: () async {
        // Increment activeStep, when the next button is tapped. However, check for upper bound.
        if (controller.activeStep == 1) {
          if (controller.addressKey.currentState?.validate() ?? false) {
            controller.addressKey.currentState?.save();

            if (controller.activeStep < upperBound) {
              controller.updateActiveStep(++controller.activeStep);
              print(controller.activeStep);
            }
            await controller.saveAddreesInFire(AddressModelInfo(
                street1: controller.street1,
                street2: controller.street2,
                city: controller.city,
                state: controller.state,
                country: controller.country,
                isSameDelivery: controller.isSameBiling));
            print('zeco');
          }
        } else {
          if (controller.activeStep < upperBound) {
            controller.updateActiveStep(++controller.activeStep);
            print(controller.activeStep);
          }
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: CustomText(
          txt: 'Next',
          fontsize: 20,
          color: Colors.white,
        ),
      ),
    );
  }

  /// Returns the previous button.
  Widget previousButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
      ),
      onPressed: () {
        // Decrement activeStep, when the previous button is tapped. However, check for lower bound i.e., must be greater than 0.
        if (controller.activeStep > 0) {
          controller.updateActiveStep(--controller.activeStep);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: CustomText(
          txt: 'Prev',
          color: Colors.black,
          fontsize: 20,
        ),
      ),
    );
  }

  /// Returns the header wrapping the header text.
  String headerText() {
    switch (controller.activeStep) {
      case 0:
        return 'Delivery';

      case 1:
        return 'Address';

      case 2:
        return 'Summer';

      default:
        return 'checkout';
    }
  }
}
