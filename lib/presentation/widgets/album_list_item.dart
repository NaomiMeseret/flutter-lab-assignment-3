import 'package:flutter/material.dart';
import '../../data/models/album_with_photo.dart';

// This widget displays a single album in the list
class AlbumListItem extends StatelessWidget {
  // The album data to display
  final AlbumWithPhoto albumWithPhoto;

  const AlbumListItem({
    Key? key,
    required this.albumWithPhoto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Create a card to display the album
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 2.0,
      color: Colors.brown[50],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(color: Colors.brown[200]!, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.brown[100],
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6.0),
                child: _buildThumbnail(),
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Album title
                  Text(
                    albumWithPhoto.album.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown[800],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 4),

                  // Album ID
                  Text(
                    'Album ID: ${albumWithPhoto.album.id}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.brown[600],
                    ),
                  ),
                ],
              ),
            ),

            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.brown[400],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThumbnail() {
    try {
      return Image.network(
        albumWithPhoto.photo.getWorkingThumbnailUrl(),
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
          print('Error loading image: $error');
          return Center(
            child: Icon(
              Icons.photo_album,
              color: Colors.brown[400],
              size: 30,
            ),
          );
        },
      );
    } catch (e) {
      return Center(
        child: Icon(
          Icons.photo_album,
          color: Colors.brown[400],
          size: 30,
        ),
      );
    }
  }
}