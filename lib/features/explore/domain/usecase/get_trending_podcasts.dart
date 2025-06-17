import 'package:injectable/injectable.dart';

import '../entities/podcast_entity.dart';
import '../repositories/podcast_repository.dart';

@injectable
class GetTrendingPodcasts {
  final PodcastRepository repository;

  GetTrendingPodcasts(this.repository);

  Future<List<PodcastEntity>> call() async {
    return await repository.getTrendingPodcasts();
  }
}
