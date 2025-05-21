import '../api/api_service.dart';
import '../models/album.dart';
import '../models/photo.dart';
import '../models/album_with_photo.dart';

// This class is responsible for getting and combining album and photo data
class AlbumRepository {
  // The API service to get data from
  final ApiService _apiService;

  AlbumRepository({ApiService? apiService})
      : _apiService = apiService ?? ApiService();

  Future<List<AlbumWithPhoto>> getAlbumsWithPhotos() async {
    try {
      // Step 1: Get albums from the API
      print('Getting albums from API...');
      final List<Album> albums = await _apiService.getAlbums();
      print('Got ${albums.length} albums');

      // Step 2: Get photos from the API
      print('Getting photos from API...');
      final List<Photo> photos = await _apiService.getPhotos();
      print('Got ${photos.length} photos');

      // Step 3: Combine albums with their photos
      print('Combining albums with photos...');
      List<AlbumWithPhoto> albumsWithPhotos = [];

      for (var album in albums) {

        Photo? matchingPhoto;

        for (var photo in photos) {
          if (photo.albumId == album.id) {
            matchingPhoto = photo;
            break;
          }
        }

        if (matchingPhoto == null) {
          print('No photo found for album ${album.id}. Using default.');

          // Create a default photo with the same albumId
          matchingPhoto = Photo(
            id: album.id,
            albumId: album.id,
            title: 'No photo available',
            url: 'placeholder',
            thumbnailUrl: 'placeholder',
          );
        }

        albumsWithPhotos.add(AlbumWithPhoto(
          album: album,
          photo: matchingPhoto,
        ));
      }

      print('Created ${albumsWithPhotos.length} album-photo pairs');
      return albumsWithPhotos;

    } catch (e) {
      print('Error in repository: $e');
      throw Exception('Failed to get albums with photos: $e');
    }
  }

  void dispose() {
    _apiService.dispose();
  }
}