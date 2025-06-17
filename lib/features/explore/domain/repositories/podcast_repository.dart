import '../entities/podcast_entity.dart';

abstract class PodcastRepository {
  Future<List<PodcastEntity>> getTrendingPodcasts();
}
