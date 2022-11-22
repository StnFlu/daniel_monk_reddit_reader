import 'package:daniel_monk_reddit_reader/app/models/comment.dart';
import 'package:daniel_monk_reddit_reader/resources/shared_components/upvote_downvote.dart';
import 'package:daniel_monk_reddit_reader/resources/shared_components/user_icon.dart';
import 'package:flutter/material.dart';

class CommentFull extends StatelessWidget {
  const CommentFull({super.key, required this.comment});

  final Comment comment;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(comment.body, style:  textTheme.subtitle1,),

          Row(
            children: [
              UpvoteDownvote(score: comment.score, vertical: false,),

              UserIcon(author: comment.author),
            ],
          )

        ],
      ),
    );
  }
}