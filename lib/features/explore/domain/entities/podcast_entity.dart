import 'package:equatable/equatable.dart';

class PodcastEntity extends Equatable {
  final String id;
  final String title;
  final String author;
  final String imageUrl;
  final Duration duration;
  final String description;
  final String audioUrl;
  final String categoryId;
  final List<int> genreIds;

  const PodcastEntity({
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

  @override
  List<Object?> get props => [id];
}
