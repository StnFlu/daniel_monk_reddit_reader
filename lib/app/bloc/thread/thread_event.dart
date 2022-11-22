part of 'thread_bloc.dart';



abstract class ThreadEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ThreadFetched extends ThreadEvent {}