class MyVideo {
  final String videoId;
  final String title;
  final String thumbnailUrl;
  final String duration;
  final String publishDate;
  final String image;
  final String filePath;

  MyVideo({
    required this.videoId,
    required this.title,
    required this.thumbnailUrl,
    required this.duration,
    required this.publishDate,
    required this.image,
    this.filePath = '',
  });
}