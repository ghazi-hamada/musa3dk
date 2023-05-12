import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:musa3dk/controller/chat/chatScreen_controller.dart';

final _firestore = FirebaseFirestore.instance;
late User signedInUser;

class ChatScreen extends StatelessWidget {
  ChatScreen({Key? key}) : super(key: key);
  var data = Get.arguments['email'];
  var isDone = Get.arguments['isDone'];
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ChatScreenControllerImp());
    return GetBuilder<ChatScreenControllerImp>(
        builder: (controller) => Scaffold(
              appBar: AppBar(
                iconTheme: const IconThemeData(color: Color(0xffF2D86F)),
                centerTitle: true,
                backgroundColor: Colors.white,
                elevation: 0.0,
                title: Text(
                  "22".tr,
                  style: const TextStyle(
                      fontFamily: "Inria_Serif",
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                actions: [
                  isDone
                      ? const Text('')
                      : IconButton(
                          onPressed: () {
                            print("${Get.arguments['id']}");
                            Get.toNamed('/Evaluation', arguments: {
                              'email': data,
                              'id': Get.arguments['id'],
                            });
                          },
                          icon: Image.asset('assets/images/xchat.png')),
                  IconButton(
                      onPressed: () {},
                      icon: Image.asset('assets/images/call.png')),
                ],
              ),
              body: SafeArea(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MessageStreamBuilder(data: controller.data),
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Color(0xffFFD65B),
                          width: 2,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: controller.messageTextController,
                            onChanged: (value) {
                              controller.messageText = value;
                            },
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 20,
                                ),
                                hintText: '38'.tr,
                                border: InputBorder.none),
                          ),
                        ),
                        FutureBuilder(
                          future: FirebaseFirestore.instance
                              .collection('users')
                              .where(
                                "email",
                                isEqualTo:
                                    FirebaseAuth.instance.currentUser!.email,
                              )
                              .get(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return IconButton(
                                onPressed: () {
                                  controller.messageTextController.clear();

                                  _firestore
                                      .collection('Orders')
                                      .doc(controller.data)
                                      .collection('chat')
                                      .add(
                                    {
                                      'text': controller.messageText,
                                      'sender': signedInUser.email,
                                      'name': snapshot.data!.docs[0]['name'],
                                      'time': FieldValue.serverTimestamp()
                                    },
                                  );
                                },
                                icon: const Icon(
                                  Icons.send,
                                  color: Color(0xfFFFD65B),
                                ),
                              );
                            }
                            return const Center(
                                child: CircularProgressIndicator());
                          },
                        )
                      ],
                    ),
                  ),
                ],
              )),
            ));
  }
}

class MessageStreamBuilder extends StatelessWidget {
  const MessageStreamBuilder({super.key, required this.data});
  final data;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('Orders')
          .doc(data)
          .collection('chat')
          .orderBy('time')
          .snapshots(),
      builder: (context, snapshot) {
        List<MessageLine> messageWidgets = [];
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final messages = snapshot.data?.docs.reversed;
        for (var message in messages!) {
          final messageText = message.get('text');
          final messsageSender = message.get('name');
          final messsageEmail = message.get('sender');
          final currentUser = signedInUser.email;
          final messageWidget = MessageLine(
            sender: messsageSender,
            text: messageText,
            isMe: currentUser == messsageEmail,
          );
          messageWidgets.add(messageWidget);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            children: messageWidgets,
          ),
        );
      },
    );
  }
}

class MessageLine extends StatelessWidget {
  const MessageLine({super.key, this.sender, this.text, required this.isMe});
  final String? sender;
  final String? text;
  final bool isMe;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            '$sender',
            style: TextStyle(fontSize: 12, color: Colors.yellow[900]),
          ),
          Material(
            elevation: 5,
            borderRadius: isMe
                ? const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  )
                : const BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
            color: isMe ? const Color(0xff72DFD0) : Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              child: Text(
                '$text',
                style: TextStyle(
                    fontSize: 15, color: isMe ? Colors.white : Colors.black87),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
