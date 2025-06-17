import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

@LazySingleton()
class PodcastRemoteDataSource {
  final String _baseUrl = 'https://listen-api-test.listennotes.com/api/v2';

  Future<List<Map<String, dynamic>>> getTrendingPodcasts() async {
    final uri = Uri.parse('$_baseUrl/best_podcasts');

    print('🔁 Calling: $uri');

    final response = await http.get(uri);

    print('✅ Status Code: ${response.statusCode}');
    print('📦 Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      final List podcasts = decoded['podcasts'];
      print('🎧 Fetched ${podcasts.length} podcasts');
      return podcasts.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to fetch trending podcasts — ${response.statusCode}: ${response.body}');
    }
  }
}
