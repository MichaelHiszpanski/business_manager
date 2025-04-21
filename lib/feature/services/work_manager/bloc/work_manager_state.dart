part of 'work_manager_bloc.dart';

sealed class WorkManagerState extends Equatable {
  final List<MeetingModel> meetings;

  const WorkManagerState({this.meetings = const []});

  WorkManagerState copyWith({List<MeetingModel>? meetings});
}

final class WorkManagerInitial extends WorkManagerState {
  const WorkManagerInitial() : super(meetings: const []);

  @override
  WorkManagerState copyWith({List<MeetingModel>? meetings}) {
    return const  WorkManagerInitial();
  }

  @override
  List<Object> get props => [meetings];
}

final class WorkManagerLoaded extends WorkManagerState {
  const WorkManagerLoaded({List<MeetingModel> meetings = const []}) : super(meetings: meetings);

  @override
  WorkManagerState copyWith({List<MeetingModel>? meetings}) {
    return WorkManagerLoaded(
      meetings: meetings ?? this.meetings,
    );
  }

  @override
  List<Object> get props => [meetings];
}
