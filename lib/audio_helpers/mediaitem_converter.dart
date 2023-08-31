import 'package:audio_service/audio_service.dart';

class MediaItemConverter {
  static MediaItem mapToMediaItem(Map song,
      {bool addedByAutoplay = false,
      bool autoplay = true,
      String? playlistBox}) {
    return MediaItem(
      id: song['id'].toString(),
      album: song['album'].toString(),
      artist: song['artist'].toString(),
      duration: Duration(
         seconds: int.parse(
          (song['duration'] == null ||
                  song['duration'] == 'null' ||
                  song['duration'] == '')
              ? '180'
              : song['duration'].toString(),
        ),
      ),
      title: song['title'].toString(),
      artUri: Uri.parse(
        getImageUrl(song['image'].toString()),
      ),
      genre: song['language'].toString(),
      extras: {
        'user_id': song['user_id'],
        'url': song['url'],
        'album_id': song['album_id'],
        'addedByAutoplay': addedByAutoplay,
        'autoplay': autoplay,
        'playlistBox': playlistBox,
      },
    );
  }
}

String getImageUrl(String? imageUrl, {String quality = 'high'}) {
  if (imageUrl == null) return '';
  switch (quality) {
    case 'high':
      return imageUrl.trim()
      .replaceAll("http:", "https:")
      .replaceAll("50x50", "500x500")
      .replaceAll("150x150", "500x500");
    case 'medium':
      return imageUrl
          .trim()
          .replaceAll("http:", "https:")
          .replaceAll("50x50", "150x150")
          .replaceAll("500x500", "150x150");
    case 'low':
      return imageUrl
          .trim()
          .replaceAll("http:", "https:")
          .replaceAll("150x150", "50x50")
          .replaceAll("500x500", "50x50");
    default:
      return imageUrl
          .trim()
          .replaceAll("http:", "https:")
          .replaceAll("50x50", "500x500")
          .replaceAll("150x150", "500x500");
  }
}
