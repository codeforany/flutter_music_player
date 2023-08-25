import 'package:get/get.dart';

class PlaylistsViewModel extends GetxController {
    final playlistArr = [
        {
            "image":"assets/img/playlist_1.png",
            "name":"My Top Tracks",
            "songs":"100 Songs"
        },
        {
            "image": "assets/img/playlist_2.png",
            "name": "Latest Added",
            "songs": "323 Songs"
        },
        {
            "image": "assets/img/playlist_3.png",
            "name": "History",
            "songs": "450 Songs"
        },
        {
            "image": "assets/img/playlist_4.png",
            "name": "Favorites",
            "songs": "966 Songs"
        }
    ].obs;

    final myPlaylistArr = [
        {
            "image": "assets/img/mp_1.png",
            "name": "Queens Collection"
        },
        {
            "image": "assets/img/mp_2.png",
            "name": "Rihanna Collection"
        },
        {
            "image": "assets/img/mp_3.png",
            "name": "MJ Collection"
        },
        {
            "image": "assets/img/mp_4.png",
            "name": "Classical Collection"
        }
    ].obs;

}
