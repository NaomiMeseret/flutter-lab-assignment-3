import '../../data/models/album_with_photo.dart';

// Base class for all album states
abstract class AlbumState {}

// Initial state when the app starts
class AlbumInitialState extends AlbumState {}

// Loading state when albums are being loaded
class AlbumLoadingState extends AlbumState {}

class AlbumLoadedState extends AlbumState {
  final List<AlbumWithPhoto> albums;

  AlbumLoadedState(this.albums);
}

class AlbumErrorState extends AlbumState {

  final String message;

  AlbumErrorState(this.message);
}