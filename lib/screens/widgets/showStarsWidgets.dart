import 'package:flutter/material.dart';
import 'package:musa3dk/screens/widgets/showStars.dart';

class ShowStarsWidgets extends StatelessWidget {
  const ShowStarsWidgets({
    super.key,
    required this.rating,
  });
  final double rating;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
            horizontalTitleGap: 10,
            minLeadingWidth: 0,
            minVerticalPadding: 1,
            leading: const Icon(Icons.star_purple500_outlined),
            title: ShowStars(starsItem: rating)),
        Container(
          color: Colors.black,
          height: 1,
        ),
      ],
    );
  }
}
