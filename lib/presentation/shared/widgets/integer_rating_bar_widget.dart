import 'package:flutter/material.dart';

class IntegerRatingBarWidget extends StatelessWidget {
  final int initialRating;
  final int itemCount;
  const IntegerRatingBarWidget(
      {required this.initialRating, this.itemCount = 5, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        itemCount,
        (index) {
          return Icon(
            index < initialRating ? Icons.star : Icons.star_border,
            color: Colors.amber,
          );
        },
      ),
    );
  }
}
