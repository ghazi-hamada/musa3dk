import 'package:flutter/material.dart';

class buttonLang extends StatelessWidget {
  const buttonLang({
    Key? key,
    required this.text,
    required this.function,
  }) : super(key: key);
  final void Function()? function;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 100),
      width: double.infinity,
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        textColor: Colors.white,
        color: Colors.cyan,
        onPressed: function,
        child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
