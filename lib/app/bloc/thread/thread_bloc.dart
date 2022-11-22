import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:daniel_monk_reddit_reader/app/controllers/thread_controller.dart';
import 'package:daniel_monk_reddit_reader/app/models/thread.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';

part 'thread_event.dart';
part 'thread_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class ThreadBloc extends Bloc<ThreadEvent, ThreadState> {
  final ThreadController threadController;

  ThreadBloc({required this.threadController}) : super(const ThreadState()) {
    on<ThreadFetched>(
      _onThreadFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  Future<void> _onThreadFetched(ThreadFetched event, Emitter<ThreadState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == ThreadStatus.initial) {
        final threads = await _fetchThreads();
        return emit(state.copyWith(
          status: ThreadStatus.success,
          threads: threads,
          hasReachedMax: false,
        ));
      }
      List<Thread>? threads;
      if(state.threads.isEmpty){
        threads = await _fetchThreads();
      } else {
        threads = await _fetchThreads(state.threads.last.name);
      }
      emit(threads.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
        status: ThreadStatus.success,
        threads: List.of(state.threads)..addAll(threads),
        hasReachedMax: false,
      ));
    } on DioError catch (error) {
      if(error.type == DioErrorType.other){
        emit(state.copyWith(status: ThreadStatus.timeout));
        return;
      }
      emit(state.copyWith(status: ThreadStatus.failure));
    }
  }

  Future<List<Thread>> _fetchThreads([String? nextPage]) async {
    final response = await threadController.getThreads(nextPage: nextPage );
    if (response.statusCode == 200) {
      return Thread.fromJsonList(response.data['data']['children']);
    }
    throw Exception('error fetching posts');
  }
}
