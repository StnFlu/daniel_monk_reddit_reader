import 'package:daniel_monk_reddit_reader/app/models/thread.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThreadListItem extends StatelessWidget {
  const ThreadListItem({super.key, required this.thread});

  final Thread thread;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      clipBehavior: Clip.hardEdge,
      elevation: 0,
      child: InkWell(
        onTap: (){
          Get.toNamed('/home/thread/', parameters: {'permalink' : thread.permalink});
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(thread.title, style:  textTheme.subtitle1, maxLines: 2, overflow: TextOverflow.ellipsis,),
                    Text(thread.selfText ?? "", maxLines: 3, overflow: TextOverflow.ellipsis,),
                    Row(
                      children: [
                        Icon(Icons.person, color: textTheme.caption?.color,),
                        Text(thread.author, style: textTheme.caption),
                      ],
                    )
                  ],
                ),
              ),
              Column(
                children: [
                  const Icon(Icons.arrow_upward),
                  Text(thread.score.toString()),
                  const Icon(Icons.arrow_downward)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}