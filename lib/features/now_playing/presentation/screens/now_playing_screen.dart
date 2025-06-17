import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:just_audio/just_audio.dart';

class NowPlayingScreen extends StatefulWidget {
  final String image;
  final String title;
  final String author;
  final String audioUrl;

  const NowPlayingScreen({
    super.key,
    required this.image,
    required this.title,
    required this.author,
    required this.audioUrl,
  });

  @override
  State<NowPlayingScreen> createState() => _NowPlayingScreenState();
}

class _NowPlayingScreenState extends State<NowPlayingScreen> {
  late final AudioPlayer _player;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    try {
      await _player.setUrl(widget.audioUrl);
    } catch (e) {
      debugPrint('❌ Audio loading error: $e');
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0C1D),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Now Playing',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Image.asset(
            'assets/icons/back_icon.png',
            width: 24,
            height: 24,
            color: Colors.white,
          ),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 38),
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                widget.image,
                height: 240,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              widget.author,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            StreamBuilder<Duration>(
              stream: _player.positionStream,
              builder: (context, snapshot) {
                final position = snapshot.data ?? Duration.zero;
                final duration = _player.duration ?? Duration.zero;

                return Column(
                  children: [
                    Slider(
                      value: position.inSeconds.toDouble().clamp(0, duration.inSeconds.toDouble()),
                      max: duration.inSeconds.toDouble().clamp(1, double.infinity),
                      min: 0,
                      onChanged: (value) {
                        _player.seek(Duration(seconds: value.toInt()));
                      },
                      activeColor: Colors.white,
                      inactiveColor: Colors.white24,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _formatDuration(position),
                          style: const TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                        Text(
                          _formatDuration(duration),
                          style: const TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Image.asset(
                    'assets/icons/backward_icon.png',
                    width: 40,
                    height:40,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    final current = await _player.position;
                    final newPosition = current - const Duration(seconds: 10);
                    _player.seek(newPosition > Duration.zero ? newPosition : Duration.zero);
                  },
                ),
                const SizedBox(width: 15),
                StreamBuilder<PlayerState>(
                  stream: _player.playerStateStream,
                  builder: (context, snapshot) {
                    final playing = snapshot.data?.playing ?? false;
                    return IconButton(
                      icon: Icon(
                        playing ? Icons.pause_circle : Icons.play_circle,
                        color: Colors.white,
                        size: 66,
                      ),
                      onPressed: () {
                        playing ? _player.pause() : _player.play();
                      },
                    );
                  },
                ),
                const SizedBox(width: 15),
                IconButton(
                  icon: Image.asset(
                    'assets/icons/forward_icon.png',
                    width: 40,
                    height: 40,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    final current = await _player.position;
                    final duration = _player.duration ?? Duration.zero;
                    final newPosition = current + const Duration(seconds: 10);
                    _player.seek(newPosition < duration ? newPosition : duration);
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
