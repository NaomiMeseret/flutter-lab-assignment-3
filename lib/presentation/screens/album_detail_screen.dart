import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../data/models/album_with_photo.dart';

class AlbumDetailScreen extends StatelessWidget {
  final AlbumWithPhoto albumWithPhoto;

  const AlbumDetailScreen({
    Key? key,
    required this.albumWithPhoto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Album Details',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.brown,
        toolbarHeight: 70,
        titleSpacing: 8,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.brown[100],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  albumWithPhoto.album.title,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown[800],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.brown[50],
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.brown[200]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Album ID: ${albumWithPhoto.album.id}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.brown[700],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'User ID: ${albumWithPhoto.album.userId}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.brown[700],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Photo',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown[700],
                ),
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.brown[50],
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.brown[200]!),
                ),
                child: Text(
                  albumWithPhoto.photo.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    color: Colors.brown[600],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.brown[50],
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.brown[200]!),
                ),
                child: _buildPhotoImage(),
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.brown[50],
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.brown[200]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Photo ID: ${albumWithPhoto.photo.id}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.brown[700],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Album ID: ${albumWithPhoto.photo.albumId}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.brown[700],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPhotoImage() {
    try {
      return ClipRRect(
        borderRadius: BorderRadius.circular(7.0),
        child: Image.network(
          albumWithPhoto.photo.getWorkingImageUrl(),
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                color: Colors.brown,
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            print('Error loading detail image: $error');
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.photo_album,
                    size: 50,
                    color: Colors.brown[400],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Image could not be loaded',
                    style: TextStyle(
                      color: Colors.brown[700],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    } catch (e) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.photo_album,
              size: 50,
              color: Colors.brown[400],
            ),
            const SizedBox(height: 8),
            Text(
              'Image could not be loaded',
              style: TextStyle(
                color: Colors.brown[700],
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }
  }
}