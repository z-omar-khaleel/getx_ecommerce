import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:http/http.dart' as http;

class StripeTransactionResponse {
  String message;
  bool success;

  StripeTransactionResponse({required this.message, required this.success});
}

class StripeService {
  static String apiURL = 'https://api.stripe.com/v1';
  static String paymentApiUrl = '${StripeService.apiURL}/payment_intents';
  static String secret =
      'sk_test_51J3KwpJIsrOAGxbtyu0UxY47AjmcDsLzCUw5q0DfGajXwv3lto27TW5SH4SMrzeRDouW42uQY9NwSoGFAgUbGBxL00fnqBEqWm'; //your secret from stripe dashboard
  static Map<String, String> headers = {
    'Authorization': 'Bearer ${StripeService.secret}',
    'Content-Type': 'application/x-www-form-urlencoded'
  };
  static init() {
    StripePayment.setOptions(StripeOptions(
        publishableKey:
            "pk_test_51J3KwpJIsrOAGxbtysWTZxC73ySasAan9SXiun8V6a8RxmMdpOVUi9LI1veI6e1QlFV7hiaRn15SM0sKBBGlAds800tcooN5Ao", // user your api key
        merchantId: "Test",
        androidPayMode: 'test'));
  }

  static Future<Map<String, dynamic>> createPaymentIntent(
      String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount':
            amount, // amount charged will be specified when the method is called
        'currency': currency, // the currency
        'payment_method_types[]': 'card' //card
      };
      var response = await http.post(
          Uri.parse(StripeService.paymentApiUrl), //api url
          body: body, //request body
          headers: StripeService
              .headers //headers of the request specified in the base class
          );
      return jsonDecode(response.body); //decode the response to json
    } catch (error) {
      print('Error occured : ${error.toString()}');
    }
    return {};
  }

  static Future<StripeTransactionResponse> addNewCard(
      {required String amount, required String currency}) async {
    try {
      var stripePaymentMethod = await StripePayment.paymentRequestWithCardForm(
          CardFormPaymentRequest());
      var stripePaymentIntent =
          await StripeService.createPaymentIntent(amount, currency);
      var response = await StripePayment.confirmPaymentIntent(PaymentIntent(
          clientSecret: stripePaymentIntent['client_secret'],
          paymentMethodId: stripePaymentMethod.id));

      if (response.status == 'succeeded') {
        //if the payment process success
        return new StripeTransactionResponse(
            message: 'Transaction successful', success: true);
      } else {
        //payment process fail
        return new StripeTransactionResponse(
            message: 'Transaction failed', success: false);
      }
    } on PlatformException catch (error) {
      return StripeService.getPlatformExceptionErrorResult(error);
    } catch (error) {
      return new StripeTransactionResponse(
          //convert the error to string and assign to message variable
          message: 'Transaction failed: ${error.toString()}',
          success: false);
    }
  }

  static getPlatformExceptionErrorResult(err) {
    String message = "Something went Error";
    if (err.code == 'cancelled')
      message = "Transaction Cancelled"; //لما ما يكمل العملية

    return StripeTransactionResponse(message: message, success: false);
  }

  static Future<StripeTransactionResponse> choseExistingCard(
      {required String amount,
      required String currency,
      required CreditCard card}) async {
    try {
      var stripePaymentMethod = await StripePayment.createPaymentMethod(
          PaymentMethodRequest(card: card));
      var stripePaymentIntent =
          await StripeService.createPaymentIntent(amount, currency);
      var response = await StripePayment.confirmPaymentIntent(PaymentIntent(
          clientSecret: stripePaymentIntent['client_secret'],
          paymentMethodId: stripePaymentMethod.id));

      if (response.status == 'succeeded') {
        //if the payment process success
        return new StripeTransactionResponse(
            message: 'Transaction successful', success: true);
      } else {
        //payment process fail
        return new StripeTransactionResponse(
            message: 'Transaction failed', success: false);
      }
    } on PlatformException catch (error) {
      return StripeService.getPlatformExceptionErrorResult(error);
    } catch (error) {
      return new StripeTransactionResponse(
          //convert the error to string and assign to message variable for json resposne
          message: 'Transaction failed: ${error.toString()}',
          success: false);
    }
  }
}
