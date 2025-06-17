import 'package:equatable/equatable.dart';
import '../../domain/entities/podcast_entity.dart';
import '../../../../core/constants/genre_mapping.dart';

class PodcastModel extends Equatable {
  final String id;
  final String title;
  final String author;
  final String imageUrl;
  final Duration duration;
  final String description;
  final String audioUrl;
  final String categoryId;
  final List<int> genreIds;

  const PodcastModel({
    required this.id,
    required this.title,
    required this.author,
    required this.imageUrl,
    required this.duration,
    required this.description,
    required this.audioUrl,
    required this.categoryId,
    required this.genreIds,
  });

  factory PodcastModel.fromJson(Map<String, dynamic> json) {
    final genreIds = (json['genre_ids'] as List?)?.map((e) => e as int).toList() ?? [];

    return PodcastModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      author: json['publisher'] ?? '',
      imageUrl: json['image'] ?? json['thumbnail'] ?? '',
      duration: Duration(seconds: json['audio_length_sec'] ?? 0),
      description: json['description'] ?? '',
      audioUrl: json['listennotes_url'] ?? '',
      categoryId: mapGenreToCategory(genreIds),
      genreIds: genreIds,
    );
  }

  PodcastEntity toEntity() => PodcastEntity(
    id: id,
    title: title,
    author: author,
    imageUrl: imageUrl,
    duration: duration,
    description: description,
    audioUrl: audioUrl,
    categoryId: categoryId,
    genreIds: genreIds,
  );

  @override
  List<Object?> get props => [id];
}
