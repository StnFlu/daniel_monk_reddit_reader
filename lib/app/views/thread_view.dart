import 'package:daniel_monk_reddit_reader/app/controllers/thread_controller.dart';
import 'package:daniel_monk_reddit_reader/app/models/thread.dart';
import 'package:daniel_monk_reddit_reader/app/models/comment.dart';
import 'package:daniel_monk_reddit_reader/resources/shared_components/comment_full.dart';
import 'package:daniel_monk_reddit_reader/resources/shared_components/thread_full.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  bool _loading = true;

  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  void _fetchData() async {
    if(_permaLink == null) return;
    try {
      var response = await _threadController.getThread(permalink: _permaLink!);
      thread = Thread.fromJson(response.data[0]['data']['children'][0]);
      comments = Comment.fromJsonList(response.data[1]['data']['children']);
    } catch (error){

    }
    if(mounted) {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Visibility(
        visible: !_loading,
        replacement: const Center(child: CircularProgressIndicator()),
        child: Visibility(
          visible: thread != null,
          replacement:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(child: Text('Failed to fetch posts, check your connection.')),
            IconButton(onPressed: () => _fetchData()
                , icon: const Icon(Icons.restart_alt))
          ],
        ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                if(thread != null)
                ThreadFull(thread: thread!,),
                const Divider(),
                if(comments != null)
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: comments!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CommentFull(comment: comments![index],)
                    );
                  }, separatorBuilder: (BuildContext context, int index) {
                      return const Divider(
                        indent: 20,
                        endIndent: 20,
                      );
                  },


                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
