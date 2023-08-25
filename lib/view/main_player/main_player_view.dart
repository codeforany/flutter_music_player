import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/common_widget/player_bottom_button.dart';
import 'package:music_player/view/main_player/driver_mode_view.dart';
import 'package:music_player/view/main_player/play_playlist_view.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../../common/color_extension.dart';

class MainPlayerView extends StatefulWidget {
  const MainPlayerView({super.key});

  @override
  State<MainPlayerView> createState() => _MainPlayerViewState();
}

class _MainPlayerViewState extends State<MainPlayerView> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColor.bg,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Image.asset(
            "assets/img/back.png",
            width: 25,
            height: 25,
            fit: BoxFit.contain,
          ),
        ),
        title: Text(
          "Now Playing",
          style: TextStyle(
              color: TColor.primaryText80,
              fontSize: 17,
              fontWeight: FontWeight.w600),
        ),
        actions: [
           PopupMenuButton<int>(
                    color: const Color(0xff383B49),
                    offset: const Offset(-10, 15),
                    elevation: 1,
                    icon: Image.asset(
                      "assets/img/more_btn.png",
                      width: 20,
                      height: 20,
                      color: Colors.white,
                    ),
                    
                    padding: EdgeInsets.zero,
                    onSelected: (selectIndex) {
                        if(selectIndex == 9) {
                          Get.to( () => const DriverModeView() );
                        }
                    },
                    itemBuilder: (context) {
                      return [
                        const PopupMenuItem(
                          value: 1,
                          height: 30,
                          child: Text(
                            "Social Share",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        const PopupMenuItem(
                          value: 2,
                           height: 30,
                          child: Text(
                            "Playing Queue",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                         const PopupMenuItem(
                          value: 3,
                          height: 30,
                          child: Text(
                            "Add to playlist...",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                         const PopupMenuItem(
                          value: 4,
                           height: 30,
                          child: Text(
                            "Lyrics",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                         const PopupMenuItem(
                          value: 5,
                          height: 30,
                          child: Text(
                            "Volume",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                         const PopupMenuItem(
                          value: 6,
                          height: 30,
                          child: Text(
                            "Details",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                         const PopupMenuItem(
                          value: 7,
                          height: 30,
                          child: Text(
                            "Sleep timer",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        const PopupMenuItem(
                          value: 8,
                          height: 30,
                          child: Text(
                            "Equaliser",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        const PopupMenuItem(
                          value: 9,
                          height: 30,
                          child: Text(
                            "Driver mode",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ];
                    }),
             

         
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(media.width * 0.7),
                  child: Image.asset(
                    "assets/img/player_image.png",
                    width: media.width * 0.6,
                    height: media.width * 0.6,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: media.width * 0.6,
                  height: media.width * 0.6,
                  child: SleekCircularSlider(
                    appearance: CircularSliderAppearance(
                        customWidths: CustomSliderWidths(
                            trackWidth: 4, progressBarWidth: 6, shadowWidth: 8),
                        customColors: CustomSliderColors(
                            dotColor: const Color(0xffFFB1B2),
                            trackColor:
                                const Color(0xffffffff).withOpacity(0.3),
                            progressBarColors: [
                              const Color(0xffFB9967),
                              const Color(0xffE9585A)
                            ],
                            shadowColor: const Color(0xffFFB1B2),
                            shadowMaxOpacity: 0.05),
                        infoProperties: InfoProperties(
                          topLabelStyle: const TextStyle(
                              color: Colors.transparent,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                          topLabelText: 'Elapsed',
                          bottomLabelStyle: const TextStyle(
                              color: Colors.transparent,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                          bottomLabelText: 'time',
                          mainLabelStyle: const TextStyle(
                              color: Colors.transparent,
                              fontSize: 50.0,
                              fontWeight: FontWeight.w600),
                          // modifier: (double value) {
                          //   final time = printDuration(Duration(seconds: value.toInt()));
                          //   return '$time';
                          // }
                        ),
                        startAngle: 270,
                        angleRange: 360,
                        size: 350.0),
                    min: 0,
                    max: 100,
                    initialValue: 60,
                    onChange: (double value) {
                      // callback providing a value while its being changed (with a pan gesture)
                    },
                    onChangeStart: (double startValue) {
                      // callback providing a starting value (when a pan gesture starts)
                    },
                    onChangeEnd: (double endValue) {
                      // ucallback providing an ending value (when a pan gesture ends)
                    },
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "3:15|4:26",
              style: TextStyle(color: TColor.secondaryText, fontSize: 12),
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              "Black or White",
              style: TextStyle(
                  color: TColor.primaryText.withOpacity(0.9),
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Michael Jackson • Album - Dangerous",
              style: TextStyle(color: TColor.secondaryText, fontSize: 12),
            ),
            const SizedBox(
              height: 20,
            ),
            Image.asset(
              "assets/img/eq_display.png",
              height: 60,
              fit: BoxFit.fitHeight,
            ),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Divider(
                color: Colors.white12,
                height: 1,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 45,
                  height: 45,
                  child: IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      "assets/img/previous_song.png",
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                SizedBox(
                  width: 60,
                  height: 60,
                  child: IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      "assets/img/play.png",
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                SizedBox(
                  width: 45,
                  height: 45,
                  child: IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      "assets/img/next_song.png",
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PlayerBottomButton(
                    title: "Playlist",
                    icon: "assets/img/playlist.png",
                    onPressed: () {
                      Get.to( () => const PlayPlayListView() );
                    }),
                PlayerBottomButton(
                    title: "Shuffle",
                    icon: "assets/img/shuffle.png",
                    onPressed: () {}),
                PlayerBottomButton(
                    title: "Repeat",
                    icon: "assets/img/repeat.png",
                    onPressed: () {}),
                PlayerBottomButton(
                    title: "EQ",
                    icon: "assets/img/eq.png",
                    onPressed: () {}),
                 PlayerBottomButton(
                    title: "Favourites",
                    icon: "assets/img/fav.png",
                    onPressed: () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
