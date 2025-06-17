part of 'podcast_cubit.dart';

abstract class PodcastState extends Equatable {
  const PodcastState();

  @override
  List<Object> get props => [];
}

class PodcastInitial extends PodcastState {}

class PodcastLoading extends PodcastState {}

class PodcastLoaded extends PodcastState {
  final List<PodcastEntity> podcasts;

  const PodcastLoaded(this.podcasts);

  @override
  List<Object> get props => [podcasts];
}

class PodcastError extends PodcastState {
  final String message;

  const PodcastError(this.message);

  @override
  List<Object> get props => [message];
}
