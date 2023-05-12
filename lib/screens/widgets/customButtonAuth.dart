import 'package:flutter/material.dart';

class customButtonAuth extends StatelessWidget {
  const customButtonAuth({
    Key? key,
    required this.text,
    required this.onPress,
  }) : super(key: key);
  final String text;
  final void Function() onPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(vertical: 13),
        minWidth: double.infinity,
        color: const Color(0xff3A6067),
        textColor: Colors.white,
        onPressed: onPress,
        child: Text(
          text,
          style: const TextStyle(
              fontFamily: "Inria_Serif",
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
      ),
    );
  }
}
