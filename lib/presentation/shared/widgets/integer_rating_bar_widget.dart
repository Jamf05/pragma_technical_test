import 'package:flutter/material.dart';

const int kRatingLength = 5;

class IntegerRatingBarWidget extends StatelessWidget {
  final int initialRating;
  final int itemCount;
  const IntegerRatingBarWidget(
      {required this.initialRating, this.itemCount = kRatingLength, super.key});

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
