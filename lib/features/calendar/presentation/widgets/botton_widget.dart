import 'package:flutter/material.dart';

class BottonWidget extends StatelessWidget {
  const BottonWidget(
      {super.key,
      required this.text,
      required this.color,
      required this.onPressed,
      required this.textColor});
  final String text;
  final Color? color;
  final Color? textColor;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      padding: const EdgeInsets.all(0.0),
      child: Ink(
        height: 40,
        padding: const EdgeInsets.only(right: 20, left: 20),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
            color: color, borderRadius: BorderRadius.circular(18)),
        child: Container(
          constraints: const BoxConstraints(minHeight: 55),
          alignment: Alignment.center,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style:  TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}
