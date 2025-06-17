// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:podcastapp/features/explore/data/datasources/podcast_remote_data_source.dart'
    as _i318;
import 'package:podcastapp/features/explore/data/repositories/podcast_repository_impl.dart'
    as _i603;
import 'package:podcastapp/features/explore/domain/repositories/podcast_repository.dart'
    as _i18;
import 'package:podcastapp/features/explore/domain/usecase/get_trending_podcasts.dart'
    as _i93;
import 'package:podcastapp/features/explore/presentation/cubit/podcast_cubit.dart'
    as _i57;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i318.PodcastRemoteDataSource>(
      () => _i318.PodcastRemoteDataSource(),
    );
    gh.lazySingleton<_i18.PodcastRepository>(
      () => _i603.PodcastRepositoryImpl(gh<_i318.PodcastRemoteDataSource>()),
    );
    gh.factory<_i93.GetTrendingPodcasts>(
      () => _i93.GetTrendingPodcasts(gh<_i18.PodcastRepository>()),
    );
    gh.factory<_i57.PodcastCubit>(
      () => _i57.PodcastCubit(gh<_i93.GetTrendingPodcasts>()),
    );
    return this;
  }
}
