import 'package:ecommerce_getx/controller/cart_controller.dart';
import 'package:ecommerce_getx/controller/services/payment.dart';
import 'package:ecommerce_getx/views/screen/Home_screen.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'credit_card_screen.dart';

class StripPaymentScreen extends StatefulWidget {
  @override
  _StripPaymentScreenState createState() => _StripPaymentScreenState();
}

class _StripPaymentScreenState extends State<StripPaymentScreen> {
  bool load = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    StripeService.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Screen'),
      ),
      body: load
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: EdgeInsets.all(23),
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    Icon? icon;
                    Text? text;
                    switch (index) {
                      case 0:
                        icon = Icon(Icons.add_circle, color: Colors.green);
                        text = Text('ADD CARD');
                        break;
                      // case 1:
                      //   icon = Icon(Icons.credit_card, color: Colors.green);
                      //   text = Text('CHOOSE CARD');
                      //   break;
                    }

                    return InkWell(
                      onTap: () {
                        onItemPress(context,
                            index); //called to select the function to call depending on the method chosen
                      },
                      child: ListTile(
                        title: text,
                        leading: icon,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(
                        color: Colors.green,
                      ),
                  itemCount: 2),
            ),
    );
  }

  onItemPress(BuildContext context, int index) async {
    var state;
    var totalPrice = Get.find<CartController>();
    int price = totalPrice.totalPrice.ceil();
    switch (index) {
      case 0:
        setState(() {
          load = true;
        });
        state = await StripeService.addNewCard(
            currency: 'usd',
            amount: '$price'); // call pay via new card function
        Get.snackbar(
          'Operation Result',
          state.message,
          duration: Duration(seconds: 1),
          backgroundColor: Colors.blue,
          snackPosition: SnackPosition.BOTTOM,
          snackStyle: SnackStyle.GROUNDED,
        );
        setState(() {
          load = false;
        });
        if (state.message == 'Transaction successful') {
          totalPrice.deleteAll();
          Get.offAll(HomeScreen());
        }
        print('ok');

        break;
      // case 1:
      //   Navigator.of(context).push(MaterialPageRoute(
      //       builder: (c) => CreditCard1())); //calls the list of cards screen
      //   break;
    }
  }
}
