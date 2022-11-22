import 'package:daniel_monk_reddit_reader/app/controllers/thread_controller.dart';
import 'package:daniel_monk_reddit_reader/app/models/thread.dart';
import 'package:daniel_monk_reddit_reader/app/models/comment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../resources/shared_components/thread_list_item.dart';

class ThreadView extends StatefulWidget {
  const ThreadView({Key? key}) : super(key: key);

  @override
  State<ThreadView> createState() => _ThreadViewState();
}

class _ThreadViewState extends State<ThreadView> {
  final ThreadController _threadController = ThreadController();

  String? get _permaLink {
    if(!Get.parameters.containsKey('permalink')){
      return null;
    }
    return Get.parameters['permalink'];
  }

  Thread? thread;
  List<Comment>? comments;

  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  void _fetchData() async {
    if(_permaLink == null) return;
    var response = await _threadController.getThread(permalink: _permaLink!);
    thread = Thread.fromJson(response.data[0]['data']['children'][0]);
    comments = Comment.fromJsonList(response.data[1]['data']['children']);
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          if(thread != null)
          ThreadListItem(thread: thread!,),
          if(comments != null)
            Expanded(
              child: ListView.builder(
                itemCount: comments!.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(comments![index].score.toString()),
                );
              },


          ),
            )
        ],
      ),
    );
  }
}
