import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ShowStars extends StatelessWidget {
  const ShowStars({Key? key, required this.starsItem}) : super(key: key);
  final double starsItem;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          RatingBar.builder(
            itemSize: 20,
            initialRating: starsItem,
            direction: Axis.horizontal,
            allowHalfRating: true,
            ignoreGestures: true,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
            itemBuilder: (context, _) =>
                const Icon(Icons.star_sharp, color: Colors.amber, size: 20),
            onRatingUpdate: (rating) {},
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            '${double.parse(
              (starsItem).toStringAsFixed(1),
            )}',
            style: const TextStyle(
                fontSize: 12,
                color: Colors.black38,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
