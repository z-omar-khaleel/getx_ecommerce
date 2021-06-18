import 'package:ecommerce_getx/controller/services/payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:stripe_payment/stripe_payment.dart';

class CreditCard1 extends StatelessWidget {
  //an array of existing cards
  List cards = [
    {
      'cardNumber': '4242424242434242',
      'expiryDate': '04/22',
      'cardHolderName': 'Kaura Jerim',
      'cvvCode': '424',
      'showBackView': false,
    },
    {
      'cardNumber': '55555345966554444',
      'expiryDate': '02/25',
      'cardHolderName': 'Jerim Kaura',
      'cvvCode': '123',
      'showBackView': false,
    }
  ];

//Page widget
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CHOSE YOUR CARD'),
      ),
      body: Container(
        padding: EdgeInsets.all(23),
        child: ListView.builder(
          itemCount: cards.length,
          itemBuilder: (BuildContext context, int index) {
            var card = cards[index];
            return InkWell(
              onTap: () {
                StripeService.choseExistingCard(
                    currency: 'usd', amount: '50', card: CreditCard());
              },
              child: CreditCardWidget(
                cardNumber: card['cardNumber'],
                expiryDate: card['expiryDate'],
                cardHolderName: card['cardHolderName'],
                cvvCode: card['cvvCode'],
                showBackView: false,
              ),
            );
          },
        ),
      ),
    );
  }
}
