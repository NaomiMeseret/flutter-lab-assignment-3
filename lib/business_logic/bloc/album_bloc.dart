import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/album_repository.dart';
import 'album_event.dart';
import 'album_state.dart';

// This class manages the state of our albums
class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  // The repository to get data from
  final AlbumRepository repository;

  AlbumBloc({required this.repository}) : super(AlbumInitialState()) {
    on<LoadAlbumsEvent>(_onLoadAlbums);
    on<RefreshAlbumsEvent>(_onRefreshAlbums);
  }
  Future<void> _onLoadAlbums(
      LoadAlbumsEvent event,
      Emitter<AlbumState> emit,
      ) async {
    emit(AlbumLoadingState());

    try {
      print('Loading albums...');
      final albums = await repository.getAlbumsWithPhotos();

      print('Albums loaded successfully');
      emit(AlbumLoadedState(albums));
    } catch (e) {

      print('Error loading albums: $e');
      emit(AlbumErrorState(e.toString()));
    }
  }
  Future<void> _onRefreshAlbums(
      RefreshAlbumsEvent event,
      Emitter<AlbumState> emit,
      ) async {
    try {

      print('Refreshing albums...');
      final albums = await repository.getAlbumsWithPhotos();

      print('Albums refreshed successfully');
      emit(AlbumLoadedState(albums));
    } catch (e) {

      print('Error refreshing albums: $e');
      emit(AlbumErrorState(e.toString()));
    }
  }
}