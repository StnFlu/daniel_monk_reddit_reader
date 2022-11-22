import 'package:daniel_monk_reddit_reader/app/bloc/thread/thread_bloc.dart';
import 'package:daniel_monk_reddit_reader/resources/shared_components/bottom_loader.dart';
import 'package:daniel_monk_reddit_reader/resources/shared_components/thread_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThreadsList extends StatefulWidget {
  final ScrollController scrollController;

  const ThreadsList({super.key, required this.scrollController});

  @override
  State<ThreadsList> createState() => _ThreadsListState();
}

class _ThreadsListState extends State<ThreadsList> {

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
    context.read<ThreadBloc>().add(ThreadFetched());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThreadBloc, ThreadState>(
      builder: (context, state) {
        switch (state.status) {
          case ThreadStatus.failure:
            return const Center(child: Text('Failed to fetch posts. Please try again later.'));
          case ThreadStatus.timeout:
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(child: Text('Failed to fetch posts, check your connection.')),
                IconButton(onPressed: () => context.read<ThreadBloc>().add(ThreadFetched())
                    , icon: const Icon(Icons.restart_alt))
              ],
            );
          case ThreadStatus.success:
            if (state.threads.isEmpty) {
              return const Center(child: Text('no posts'));
            }
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return index >= state.threads.length
                    ? const BottomLoader()
                    : ThreadListItem(thread: state.threads[index]);
              },
              itemCount: state.hasReachedMax
                  ? state.threads.length
                  : state.threads.length + 1,
              controller: widget.scrollController,
            );
          case ThreadStatus.initial:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  void dispose() {
    widget.scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<ThreadBloc>().add(ThreadFetched());
  }

  bool get _isBottom {
    if (!widget.scrollController.hasClients) return false;
    final maxScroll = widget.scrollController.position.maxScrollExtent;
    final currentScroll = widget.scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}