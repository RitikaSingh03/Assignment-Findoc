class Photo {
  final String id;
  final String author;
  final String downloadUrl;
  final int width;
  final int height;

  Photo({
    required this.id,
    required this.author,
    required this.downloadUrl,
    required this.width,
    required this.height,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'].toString(),
      author: json['author'] ?? 'Unknown',
      downloadUrl: json['download_url'],
      width: json['width'] ?? 0,
      height: json['height'] ?? 0,
    );
  }
}
