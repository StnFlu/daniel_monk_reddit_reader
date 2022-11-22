import 'package:daniel_monk_reddit_reader/app/models/comment.dart';
import 'package:daniel_monk_reddit_reader/resources/shared_components/upvote_downvote.dart';
import 'package:flutter/material.dart';

class CommentFull extends StatelessWidget {
  const CommentFull({super.key, required this.comment});

  final Comment comment;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(comment.author, style: textTheme.subtitle2),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(comment.body, style:  textTheme.bodyText2,),
          ),
          Align(
            alignment: Alignment.centerRight,
              child: UpvoteDownvote(score: comment.score, vertical: false,)),

        ],
      ),
    );
  }
}