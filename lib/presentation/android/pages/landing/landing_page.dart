import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pragma_technical_test/presentation/android/pages/landing/landing_cubit/landing_cubit.dart';
import 'package:pragma_technical_test/presentation/android/pages/landing/widgets/cat_breed_card.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});
  static const String route = '/landing';

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    context.read<LandingCubit>().init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catbreeds'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 8,
            ),
            const TextField(),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 100,
                padding: const EdgeInsets.only(bottom: 8),
                itemBuilder: (BuildContext context, int index) {
                  return const CatBreedCard();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
