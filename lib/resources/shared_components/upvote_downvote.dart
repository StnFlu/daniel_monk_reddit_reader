import 'package:flutter/material.dart';

class UpvoteDownvote extends StatelessWidget {
  const UpvoteDownvote({Key? key, required this.score, this.vertical = true}) : super(key: key);
  final int score;
  final bool vertical;
  @override
  Widget build(BuildContext context) {
    return vertical ?
    Column(
      children: [
        const Icon(Icons.arrow_upward),
        Text(score.toString()),
        const Icon(Icons.arrow_downward)
      ],
    )
    :
    Row(
      children: [
        const Icon(Icons.arrow_upward),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(score.toString()),
        ),
        const Icon(Icons.arrow_downward)
      ],
    );
  }
}
