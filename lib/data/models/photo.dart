// This is a model class for Photo data
class Photo {
  final int id;
  final int albumId;
  final String title;
  final String url;
  final String thumbnailUrl;

  Photo({
    required this.id,
    required this.albumId,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  // Create a Photo from JSON data
  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'],
      albumId: json['albumId'],
      title: json['title'],
      url: json['url'],
      thumbnailUrl: json['thumbnailUrl'],
    );
  }

  String getWorkingImageUrl() {
    // Use a reliable image service
    return 'https://picsum.photos/id/${id % 1000}/600/400';
  }

  String getWorkingThumbnailUrl() {
    // Use a reliable image service
    return 'https://picsum.photos/id/${id % 1000}/150/150';
  }
}