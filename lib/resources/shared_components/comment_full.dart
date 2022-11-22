import 'package:daniel_monk_reddit_reader/app/models/comment.dart';
import 'package:daniel_monk_reddit_reader/resources/shared_components/upvote_downvote.dart';
import 'package:flutter/material.dart';

class CommentFull extends StatelessWidget {
  const CommentFull({super.key, required this.comment, this.isReply = false});

  final Comment comment;
  final bool isReply;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme
        .of(context)
        .textTheme;

    return Container(
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          border: Border(left: BorderSide(color: Theme.of(context).shadowColor.withOpacity(0.4)))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(comment.author, style: textTheme.subtitle2),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(comment.body, style: textTheme.bodyText2,),
          ),
          Align(
              alignment: Alignment.centerRight,
              child: UpvoteDownvote(score: comment.score, vertical: false,)),
          if(comment.replies != null)
          Padding(
            padding: const EdgeInsets.only(left: 6),
            child:  ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: comment.replies!.length,
              itemBuilder: (BuildContext context, int index) {
                return CommentFull(comment: comment.replies![index], isReply: true,);
              }, separatorBuilder: (BuildContext context, int index) {
              return const Divider(
                indent: 20,
                endIndent: 20,
              );
            }
            ),
          )
        ],
      ),
    );
  }
}