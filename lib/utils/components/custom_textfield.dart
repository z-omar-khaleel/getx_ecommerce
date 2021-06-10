import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomTextField extends StatelessWidget {
  final String? txt;
  final String? hint;
  String? intinalVal;
  final Function(String? s) onSaved;
  final String? Function(dynamic sz) valdator;
  final bool isObscureText;

  CustomTextField(
      {required this.txt,
      required this.hint,
      required this.onSaved,
      required this.valdator,
      required this.isObscureText,
      this.intinalVal});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomText(
          txt: txt!,
          fontsize: 15,
          color: Color.fromRGBO(0, 0, 0, .5),
        ),
        TextFormField(
          initialValue: intinalVal,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
                fontSize: 14,
                color: Colors.black87,
                fontWeight: FontWeight.bold),
          ),
          onSaved: onSaved,
          validator: valdator,
          obscureText: isObscureText,
        )
      ],
    );
  }
}
