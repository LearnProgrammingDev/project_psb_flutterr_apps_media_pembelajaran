import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() => runApp(const VideoApp());

class VideoApp extends StatefulWidget {
  const VideoApp({super.key});

  @override
  VideoAppState createState() => VideoAppState();
}

class VideoAppState extends State<VideoApp> {
  // Data video dengan informasi lengkap
  final List<VideoData> videos = [
    VideoData(
      id: 1,
      title: 'Bee Video',
      description: 'Video lebah yang indah dan menarik',
      thumbnailUrl:
          'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      videoUrl:
          'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    ),
    VideoData(
      id: 2,
      title: 'Butterfly Video',
      description: 'Video kupu-kupu yang cantik',
      thumbnailUrl:
          'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      videoUrl:
          'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    ),
    VideoData(
      id: 3,
      title: 'Big Buck Bunny',
      description: 'Film animasi pendek yang terkenal',
      thumbnailUrl:
          'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
      videoUrl:
          'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Gallery',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: VideoListScreen(videos: videos),
    );
  }
}

class VideoData {
  final int id;
  final String title;
  final String description;
  final String thumbnailUrl;
  final String videoUrl;

  VideoData({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.videoUrl,
  });
}

class VideoListScreen extends StatelessWidget {
  final List<VideoData> videos;

  const VideoListScreen({super.key, required this.videos});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Gallery'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: videos.length,
          itemBuilder: (context, index) {
            final video = videos[index];
            return VideoCard(
              video: video,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VideoPlayerScreen(video: video),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class VideoCard extends StatelessWidget {
  final VideoData video;
  final VoidCallback onTap;

  const VideoCard({super.key, required this.video, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail placeholder dengan play icon
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.blue.withOpacity(0.7),
                          Colors.purple.withOpacity(0.7),
                        ],
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.play_circle_filled,
                    size: 64,
                    color: Colors.white,
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${video.id}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Video info
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    video.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    video.description,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.play_arrow, size: 16, color: Colors.blue),
                      const SizedBox(width: 4),
                      Text(
                        'Tap to play',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  final VideoData video;

  const VideoPlayerScreen({super.key, required this.video});

  @override
  VideoPlayerScreenState createState() => VideoPlayerScreenState();
}

class VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
        Uri.parse(widget.video.videoUrl),
      )
      ..initialize().then((_) {
        setState(() {
          _isLoading = false;
        });
        // Auto play when video is loaded
        _controller.play();
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.video.title),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child:
            _isLoading
                ? const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(color: Colors.white),
                    SizedBox(height: 16),
                    Text(
                      'Loading video...',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                )
                : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Text(
                            widget.video.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            widget.video.description,
                            style: TextStyle(
                              color: Colors.grey[300],
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
      ),
      floatingActionButton:
          _isLoading
              ? null
              : FloatingActionButton(
                onPressed: () {
                  setState(() {
                    _controller.value.isPlaying
                        ? _controller.pause()
                        : _controller.play();
                  });
                },
                backgroundColor: Colors.blue,
                child: Icon(
                  _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                ),
              ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
