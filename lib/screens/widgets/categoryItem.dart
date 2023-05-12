import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({Key? key, required this.title, required this.imageUrl})
      : super(key: key);
  final String title;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        LocationPermission permission = await Geolocator.checkPermission();
        print("****************** $permission");
        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
        }
        Get.toNamed(
          "/GoogleMaps",
          arguments: {
            'title': title,
            'imageUrl': imageUrl,
          },
        );
      },
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.topCenter,
            child: Image.asset(
              imageUrl,
              height: 70,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: Colors.black12,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              title,
              style: const TextStyle(
                fontFamily: "Inria_Serif",
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
