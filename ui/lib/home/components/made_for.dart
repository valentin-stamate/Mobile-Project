import 'package:flutter/cupertino.dart';
import 'package:spotify/assets/assets.dart';
import 'package:spotify/theme/colors.dart';

class MadeFor extends StatelessWidget {
  const MadeFor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,

        children: const [
          Text(
            'Made for you',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Suggestions(),
        ],
      ),
    );
  }

}

class Suggestions extends StatelessWidget {
  const Suggestions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: ListView(
          scrollDirection: Axis.horizontal,

        children: const [
            SuggestionCard(),
            SizedBox(width: 16),
            SuggestionCard(),
            SizedBox(width: 16),
            SuggestionCard(),
            SizedBox(width: 16),
            SuggestionCard(),
          ],
        ),

    );
  }

}

class SuggestionCard extends StatelessWidget {
  const SuggestionCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 128,
      child: Column(
        children: [
          Image.asset(
            Assets.demo,
            width: 128,
            height: 128,
          ),
          const SizedBox(height: 4),
          Container(
            alignment: Alignment.topLeft,
            child: const Text(
              'Ana are mere',
              style: TextStyle(
                fontSize: 12,
                color: ThemeColors.fontDarker,
              ),
            ),
          )
        ],
      ),
    );
  }

}