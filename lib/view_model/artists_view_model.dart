import 'package:get/get.dart';

class ArtistsViewModel extends GetxController {
  final allList = [
    {
      "image": "assets/img/ar_1.png",
      "name": "Beyonce",
      "albums": "4 albums",
      "songs": "38 Songs"
    },
    {
      "image": "assets/img/ar_2.png",
      "name": "Bebe Rexha",
      "albums": "2 albums",
      "songs": "18 Songs"
    },
    {
      "image": "assets/img/ar_3.png",
      "name": "Maroon 5",
      "albums": "5 albums",
      "songs": "46 Songs"
    },
    {
      "image": "assets/img/ar_4.png",
      "name": "Michael Jackson",
      "albums": "10 albums",
      "songs": "112 Songs"
    },
    {
      "image": "assets/img/ar_5.png",
      "name": "Queens",
      "albums": "3 albums",
      "songs": "32 Songs"
    },
    {
      "image": "assets/img/ar_6.png",
      "name": "Yani",
      "albums": "1 albums",
      "songs": "13 Songs"
    }
  ].obs;


  final albumsArr = [
    {
      "image":"assets/img/ar_d_1.png",
      "name":"Fire Dragon",
      "year":"2019",
    },
    {
      "image": "assets/img/ar_d_2.png",
      "name": "Sound of Life",
      "year": "2018",
    },
    {
      "image":"assets/img/ar_d_3.png",
      "name":"Giving Heart",
      "year":"2017",
    },
    {
      "image": "assets/img/ar_d_4.png",
      "name": "Dream of",
      "year": "2016",
    },
  ];


  final playedArr = [
    {"duration": "3:56", "name": "Billie Jean", "artists": "Michael Jackson"},
    {"duration": "3:56", "name": "Earth Song", "artists": "Michael Jackson"},
    {"duration": "3:56", "name": "Mirror", "artists": "Justin Timberlake"},
    {
      "duration": "3:56",
      "name": "Remember the Time",
      "artists": "Michael Jackson"
    },
    {"duration": "3:56", "name": "Billie Jean", "artists": "Michael Jackson"},
    {"duration": "3:56", "name": "Earth Song", "artists": "Michael Jackson"},
    {"duration": "3:56", "name": "Mirror", "artists": "Justin Timberlake"},
    {
      "duration": "3:56",
      "name": "Remember the Time",
      "artists": "Michael Jackson"
    },
    {"duration": "3:56", "name": "Billie Jean", "artists": "Michael Jackson"},
    {"duration": "3:56", "name": "Earth Song", "artists": "Michael Jackson"},
    {"duration": "3:56", "name": "Mirror", "artists": "Justin Timberlake"},
    {
      "duration": "3:56",
      "name": "Remember the Time",
      "artists": "Michael Jackson"
    }
  ].obs;
 
}
