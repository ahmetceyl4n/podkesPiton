import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/podcast_entity.dart';
import 'package:injectable/injectable.dart';

import '../../domain/usecase/get_trending_podcasts.dart';

part 'podcast_state.dart';

@injectable
class PodcastCubit extends Cubit<PodcastState> {
  final GetTrendingPodcasts getTrendingPodcasts;

  PodcastCubit(this.getTrendingPodcasts) : super(PodcastInitial());

  Future<void> fetchTrending() async {
    emit(PodcastLoading());

    try {
      final podcasts = await getTrendingPodcasts();
      emit(PodcastLoaded(podcasts));
    } catch (e) {
      emit(PodcastError(e.toString()));
    }
  }
}
