import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/album.dart';
import '../models/photo.dart';

// This class is responsible for making API calls
class ApiService {
  // The base URL for the API
  final String baseUrl = 'https://jsonplaceholder.typicode.com';

  // The endpoints for albums and photos
  final String albumsEndpoint = '/albums';
  final String photosEndpoint = '/photos';

  // The HTTP client for making requests
  final http.Client client;

  ApiService({http.Client? client}) : this.client = client ?? http.Client();

  Future<List<Album>> getAlbums() async {
    try {
      // Create the full URL
      final url = '$baseUrl$albumsEndpoint';

      print('Getting albums from: $url');

      final response = await client.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Parse the JSON response
        final List<dynamic> jsonData = json.decode(response.body);

        print('Got ${jsonData.length} albums from API');

        List<Album> albums = [];
        for (var json in jsonData) {
          albums.add(Album.fromJson(json));
        }

        return albums;
      } else {
        throw Exception('Failed to load albums. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error getting albums: $e');
      throw Exception('Failed to load albums: $e');
    }
  }

  Future<List<Photo>> getPhotos() async {
    try {
      // Create the full URL
      final url = '$baseUrl$photosEndpoint';

      print('Getting photos from: $url');

      // Make the HTTP GET request
      final response = await client.get(Uri.parse(url));

      if (response.statusCode == 200) {

        final List<dynamic> jsonData = json.decode(response.body);

        print('Got ${jsonData.length} photos from API');
        List<Photo> photos = [];
        for (var json in jsonData) {
          photos.add(Photo.fromJson(json));
        }

        return photos;
      } else {

        throw Exception('Failed to load photos. Status code: ${response.statusCode}');
      }
    } catch (e) {

      print('Error getting photos: $e');
      throw Exception('Failed to load photos: $e');
    }
  }

  void dispose() {
    client.close();
  }
}