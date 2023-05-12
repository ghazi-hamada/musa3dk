import 'package:flutter/material.dart';



class Utils {
 static final messengerKey = GlobalKey<ScaffoldMessengerState>();
  static showSnackBar(String? text) {
    if (text == null) return;
    final snakBar = SnackBar(content: Text(text), backgroundColor: Colors.red);
     messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snakBar);
  }
}
showLoading(BuildContext _) {
    return showDialog(
      context: _,
      builder: (context) {
        return const AlertDialog(
          title: Text('Please Wait'),
          content: SizedBox(
            height: 50,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }