import 'album.dart';
import 'photo.dart';

// This class combines an Album with its Photo
class AlbumWithPhoto {
  final Album album;

  final Photo photo;

  AlbumWithPhoto({
    required this.album,
    required this.photo,
  });
}