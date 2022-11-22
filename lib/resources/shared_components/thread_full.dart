import 'package:daniel_monk_reddit_reader/app/models/thread.dart';
import 'package:daniel_monk_reddit_reader/resources/shared_components/comments_icon.dart';
import 'package:daniel_monk_reddit_reader/resources/shared_components/upvote_downvote.dart';
import 'package:daniel_monk_reddit_reader/resources/shared_components/user_icon.dart';
import 'package:flutter/material.dart';

class ThreadFull extends StatelessWidget {
  const ThreadFull({super.key, required this.thread});

  final Thread thread;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(thread.title, style:  textTheme.subtitle1,),
          Visibility(
            visible: thread.selfText != null,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(thread.selfText.toString(), style:  textTheme.bodyText2,),
            ),
          ),
          Row(
            children: [
              UpvoteDownvote(score: thread.score, vertical: false,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CommentsIcon(commentTotal: thread.numOfComments),
              ),
              UserIcon(author: thread.author),
            ],
          )

        ],
      ),
    );
  }
}