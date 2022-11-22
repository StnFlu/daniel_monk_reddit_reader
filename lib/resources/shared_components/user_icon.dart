import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserIcon extends StatelessWidget {
  const UserIcon({Key? key, required this.author}) : super(key: key);
  final String author;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return  Row(
      children: [
        Icon(Icons.person, color: textTheme.caption?.color,),
        Text(author, style: textTheme.caption),
      ],
    );
  }
}
