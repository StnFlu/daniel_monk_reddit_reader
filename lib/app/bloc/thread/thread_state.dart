part of 'thread_bloc.dart';

enum ThreadStatus { initial, success, timeout, failure }

class ThreadState extends Equatable {
  const ThreadState({
    this.status = ThreadStatus.initial,
    this.threads = const <Thread>[],
    this.hasReachedMax = false,
  });

  final ThreadStatus status;
  final List<Thread> threads;
  final bool hasReachedMax;

  ThreadState copyWith({
    ThreadStatus? status,
    List<Thread>? threads,
    bool? hasReachedMax,
  }) {
    return ThreadState(
      status: status ?? this.status,
      threads: threads ?? this.threads,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''ThreadState { status: $status, hasReachedMax: $hasReachedMax, threads: ${threads.length} }''';
  }

  @override
  List<Object> get props => [status, threads, hasReachedMax];
}