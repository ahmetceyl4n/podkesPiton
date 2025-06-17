import 'package:injectable/injectable.dart';

import '../../domain/entities/podcast_entity.dart';
import '../../domain/repositories/podcast_repository.dart';
import '../datasources/podcast_remote_data_source.dart';
import '../model/podcast_model.dart';

@LazySingleton(as: PodcastRepository)
class PodcastRepositoryImpl implements PodcastRepository {
  final PodcastRemoteDataSource remoteDataSource;

  PodcastRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<PodcastEntity>> getTrendingPodcasts() async {
    final response = await remoteDataSource.getTrendingPodcasts();
    return response
        .map((json) => PodcastModel.fromJson(json).toEntity())
        .toList();
  }
}
