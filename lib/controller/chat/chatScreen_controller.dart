import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../screens/messages/chat_Scteen.dart';

abstract class ChatScreenController extends GetxController{
getCurrentUser();
}

class ChatScreenControllerImp extends ChatScreenController{
    final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  var data = Get.arguments['id'];
  String? messageText;
  @override
  void onInit() {
    getCurrentUser();
    super.onInit();
  }

  @override
  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        signedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }
}