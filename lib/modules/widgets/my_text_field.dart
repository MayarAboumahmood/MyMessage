import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Mytextfield extends StatelessWidget {
  final String hintText;
  final String labletext;
  final Color enableColor;
  final Color disableColor;
  final bool scurtext;
  final TextInputType textType;
  final Function(String) myonChange;
  String? va;

  Mytextfield(
      {Key? key,
      required this.myonChange,
      required this.textType,
      required this.scurtext,
      required this.disableColor,
      required this.enableColor,
      required this.hintText,
      required this.labletext})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.05,
        right: MediaQuery.of(context).size.width * 0.05,
      ),
      child: TextField(
        keyboardType: textType,
        obscureText: scurtext,
        onChanged: myonChange,
        decoration: InputDecoration(
            labelText: labletext,
            hintText: hintText,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
              color: enableColor,
            )),
            disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
              color: disableColor,
            ))),
      ),
    );
  }
}
