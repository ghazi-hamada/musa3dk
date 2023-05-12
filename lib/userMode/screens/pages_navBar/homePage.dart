import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/data_app.dart';
import '../../../screens/widgets/categoryItem.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title:  Text(
          "1".tr,
          style: TextStyle(
              fontFamily: "Inria_Serif",
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 150,
              child: ListView.builder(
                itemCount: 3,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Container(
                  height: 130,
                  width: 280,
                  margin: const EdgeInsets.all(10),
                  // color: Colors.green[700],
                  child: Center(child: Image.asset("assets/images/29.png")),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                alignment: Alignment.topLeft,
                child:  Text(
                  "2".tr,
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            Flexible(
              child: GridView(
                padding: const EdgeInsets.all(30),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 175,
                  childAspectRatio: 7 / 8,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                children: Categories_data.map((categoryData) => CategoryItem(
                    title: categoryData.title,
                    imageUrl: categoryData.imageUrl)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
