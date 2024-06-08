import 'package:flutter/material.dart';

class CatBreedCard extends StatelessWidget {
  const CatBreedCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        minVerticalPadding: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Item 0'),
            Icon(
              Icons.arrow_forward_ios,
              size: 15,
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Placeholder(
              fallbackWidth: double.infinity,
              fallbackHeight: 100,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Pais origen'),
                Text('Inteligencia'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
