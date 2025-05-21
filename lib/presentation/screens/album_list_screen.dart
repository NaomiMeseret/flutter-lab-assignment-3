import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../business_logic/bloc/album_bloc.dart';
import '../../business_logic/bloc/album_event.dart';
import '../../business_logic/bloc/album_state.dart';
import '../widgets/album_list_item.dart';
import '../widgets/error_display.dart';

// This screen displays the list of albums
class AlbumListScreen extends StatelessWidget {
  const AlbumListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar at the top with extra padding to avoid camera
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Album List',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.brown,
        toolbarHeight: 70,
        titleSpacing: 20,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: BlocBuilder<AlbumBloc, AlbumState>(
          builder: (context, state) {
            if (state is AlbumInitialState) {
              context.read<AlbumBloc>().add(LoadAlbumsEvent());
              return const Center(
                child: CircularProgressIndicator(color: Colors.brown),
              );
            } else if (state is AlbumLoadingState) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.brown),
              );
            } else if (state is AlbumLoadedState) {
              return RefreshIndicator(
                color: Colors.brown,
                onRefresh: () async {
                  context.read<AlbumBloc>().add(RefreshAlbumsEvent());
                },
                child: ListView.builder(
                  itemCount: state.albums.length,
                  itemBuilder: (context, index) {
                    final albumWithPhoto = state.albums[index];
                    return GestureDetector(
                      onTap: () {
                        context.push(
                          '/album/${albumWithPhoto.album.id}',
                          extra: albumWithPhoto,
                        );
                      },
                      child: AlbumListItem(albumWithPhoto: albumWithPhoto),
                    );
                  },
                ),
              );
            } else if (state is AlbumErrorState) {
              return ErrorDisplay(
                message: state.message,
                onRetry: () {
                  context.read<AlbumBloc>().add(LoadAlbumsEvent());
                },
              );
            } else {
              return const Center(
                child: Text('Unknown state'),
              );
            }
          },
        ),
      ),
    );
  }
}