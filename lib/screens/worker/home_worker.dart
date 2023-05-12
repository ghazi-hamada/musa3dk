import 'package:flutter/material.dart';

class HomeWorker extends StatelessWidget {
  const HomeWorker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Worker"),
      ),
      body: const Center(
        child: Text("Welcome to wrker"),
      ),
    );
  }
}
