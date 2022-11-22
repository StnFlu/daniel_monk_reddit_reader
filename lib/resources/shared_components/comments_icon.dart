import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommentsIcon extends StatelessWidget {
  const CommentsIcon({Key? key, required this.commentTotal}) : super(key: key);
  final int commentTotal;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return  Row(
      children: [
        Icon(Icons.comment, color: textTheme.caption?.color,),
        Text(commentTotal.toString(), style: textTheme.caption),
      ],
    );
  }
}
