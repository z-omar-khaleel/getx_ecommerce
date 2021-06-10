import 'package:ecommerce_getx/model/user_info.dart';
import 'package:flutter/material.dart';

const Color primartColor = Color.fromRGBO(0, 197, 105, 1);
UserInfor? currentUser;

const kTileHeight = 50.0;
const inProgressColor = Colors.black87;
const todoColor = Color(0xffd1d2d7);

enum Pages {
  DeliveryTime,
  AddAddress,
  Summary,
}
