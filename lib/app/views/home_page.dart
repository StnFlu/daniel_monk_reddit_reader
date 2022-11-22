import 'package:daniel_monk_reddit_reader/app/bloc/thread/thread_bloc.dart';
import 'package:daniel_monk_reddit_reader/app/controllers/thread_controller.dart';
import 'package:daniel_monk_reddit_reader/resources/shared_components/threads_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ThreadController threadController = ThreadController();
  final _scrollController = ScrollController();

  late ValueNotifier<bool> _returnState;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _returnState = ValueNotifier<bool>(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: BlocProvider(
          create: (_) => ThreadBloc(threadController: threadController),
          child: ThreadsList(
            scrollController: _scrollController,
          ),
        ),
        floatingActionButton: _returnTop());
  }

  void _onScroll() {
    if (_isTop && _returnState.value == true) {
      _returnState.value = false;
      return;
    }
    if (!_isTop &&
        _returnState.value == true &&
        _scrollController.position.userScrollDirection ==
            ScrollDirection.reverse) {
      _returnState.value = false;
    }
    if (!_isTop &&
        _returnState.value == false &&
        _scrollController.position.userScrollDirection ==
            ScrollDirection.forward) {
      _returnState.value = true;
    }
  }

  Widget? _returnTop() {
    return ValueListenableProvider.value(
        value: _returnState,
        child: Consumer<bool>(builder: (context, dropState, child) {
          if (!_scrollController.hasClients) return const SizedBox();
          return AnimatedScale(
            scale: dropState ? 1: 0,
            duration: const Duration(milliseconds: 120),
            curve: Curves.easeIn,
            child: FloatingActionButton(
              onPressed: () => _scrollController.animateTo(0,
                  curve: Curves.easeIn,
                  duration: Duration(
                      milliseconds: (_scrollController.position.maxScrollExtent ~/ 40).clamp(300, 1800))),
              child: const Icon(Icons.arrow_upward),
            ),
          );
        }));
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  bool get _isTop {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.minScrollExtent + 200;
    final currentScroll = _scrollController.offset;
    return currentScroll < maxScroll;
  }
}
