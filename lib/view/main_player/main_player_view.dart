import 'dart:math';

import 'package:audio_service/audio_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/audio_helpers/page_manager.dart';
import 'package:music_player/audio_helpers/service_locator.dart';
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
    final pageManager = getIt<PageManager>();
    return Dismissible(
      key: const Key("playScreen"),
      direction: DismissDirection.down,
      background: const ColoredBox(color: Colors.transparent),
      onDismissed: (direction) {
        Get.back();
      },
      child: Scaffold(
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
                  if (selectIndex == 2) {
                    openPlayPlaylistQueue();
                  } else if (selectIndex == 9) {
                    openDriverModel();
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
        body: ValueListenableBuilder<MediaItem?>(
          valueListenable: pageManager.currentSongNotifier,
          builder: (context, mediaItem, child) {
            if (mediaItem == null) return const SizedBox();

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Hero(
                            tag: "currentArtWork",
                            child: ValueListenableBuilder(
                              valueListenable: pageManager.currentSongNotifier,
                              builder: (context, value, child) {
                                return ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(media.width * 0.7),
                                  child: CachedNetworkImage(
                                    imageUrl: mediaItem.artUri.toString(),
                                    fit: BoxFit.cover,
                                    errorWidget: (context, url, error) {
                                      return Image.asset(
                                        "assets/img/cover.jpg",
                                        fit: BoxFit.cover,
                                      );
                                    },
                                    placeholder: (context, url) {
                                      return Image.asset(
                                        "assets/img/cover.jpg",
                                        fit: BoxFit.cover,
                                      );
                                    },
                                    width: media.width * 0.6,
                                    height: media.width * 0.6,
                                  ),
                                );
                              },
                            )),
                        ValueListenableBuilder(
                          valueListenable: pageManager.progressNotifier,
                          builder: (context, valueState, child) {
                            double? dragValue;
                            bool dragging = false;

                            final value = min(
                                valueState.current.inMilliseconds.toDouble(),
                                valueState.total.inMilliseconds.toDouble());

                            if (dragValue != null && dragging) {
                              dragValue = null;
                            }

                            return SizedBox(
                              width: media.width * 0.61,
                              height: media.width * 0.61,
                              child: SleekCircularSlider(
                                appearance: CircularSliderAppearance(
                                    customWidths: CustomSliderWidths(
                                        trackWidth: 4,
                                        progressBarWidth: 6,
                                        shadowWidth: 8),
                                    customColors: CustomSliderColors(
                                        dotColor: const Color(0xffFFB1B2),
                                        trackColor: const Color(0xffffffff)
                                            .withOpacity(0.3),
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
                                    ),
                                    startAngle: 270,
                                    angleRange: 360,
                                    size: 350.0),
                                min: 0,
                                max: max(
                                    valueState.current.inMilliseconds
                                        .toDouble(),
                                    valueState.total.inMilliseconds.toDouble()),
                                initialValue: value,
                                onChange: (double value) {
                                  if (!dragging) {
                                    dragging = true;
                                  }
                                  setState(() {
                                    dragValue = value;
                                  });

                                  pageManager.seek(
                                    Duration(
                                      milliseconds: value.round(),
                                    ),
                                  );
                                },
                                onChangeStart: (double startValue) {},
                                onChangeEnd: (double endValue) {
                                  pageManager.seek(
                                    Duration(
                                      milliseconds: endValue.round(),
                                    ),
                                  );
                                  dragging = false;
                                },
                              ),
                            );
                          },
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ValueListenableBuilder(
                      valueListenable: pageManager.progressNotifier,
                      builder: (context, valueState, child) {
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                                      .firstMatch('${valueState.current}')
                                      ?.group(1) ??
                                  '${valueState.current}',
                              style: TextStyle(
                                  color: TColor.secondaryText, fontSize: 12),
                            ),
                            Text(
                              " | ",
                              style: TextStyle(
                                  color: TColor.secondaryText, fontSize: 12),
                            ),
                            Text(
                              RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                                      .firstMatch('${valueState.total}')
                                      ?.group(1) ??
                                  '${valueState.total}',
                              style: TextStyle(
                                  color: TColor.secondaryText, fontSize: 12),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      mediaItem.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: TColor.primaryText.withOpacity(0.9),
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${mediaItem.artist} • Album - ${mediaItem.album}",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(color: TColor.secondaryText, fontSize: 12),
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
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Divider(
                        color: Colors.white12,
                        height: 1,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ValueListenableBuilder<bool>(
                          valueListenable: pageManager.isFirstSongNotifier,
                          builder: (context, isFirst, child) {
                            return SizedBox(
                              width: 45,
                              height: 45,
                              child: IconButton(
                                onPressed:
                                    (isFirst) ? null : pageManager.previous,
                                icon: Image.asset(
                                  "assets/img/previous_song.png",
                                  color: (isFirst)
                                      ? TColor.primaryText35
                                      : TColor.primaryText,
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        ValueListenableBuilder<ButtonState>(
                          valueListenable: pageManager.playButtonNotifier,
                          builder: (context, value, child) {
                            return SizedBox(
                              width: 75,
                              height: 75,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  if (value == ButtonState.loading)
                                    SizedBox(
                                      width: 75,
                                      height: 75,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                TColor.primaryText),
                                      ),
                                    ),
                                  SizedBox(
                                    width: 60,
                                    height: 60,
                                    child: value == ButtonState.playing
                                        ? InkWell(
                                            onTap: pageManager.pause,
                                            child: Image.asset(
                                              "assets/img/pause.png",
                                              width: 60,
                                              height: 60,
                                            ),
                                          )
                                        : InkWell(
                                            onTap: pageManager.play,
                                            child: Image.asset(
                                              "assets/img/play.png",
                                              width: 60,
                                              height: 60,
                                            ),
                                          ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        ValueListenableBuilder<bool>(
                          valueListenable: pageManager.isLastSongNotifier,
                          builder: (context, isLast, child) {
                            return SizedBox(
                              width: 45,
                              height: 45,
                              child: IconButton(
                                onPressed: (isLast) ? null : pageManager.next,
                                icon: Image.asset(
                                  "assets/img/next_song.png",
                                  color: (isLast)
                                      ? TColor.primaryText35
                                      : TColor.primaryText,
                                ),
                              ),
                            );
                          },
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
                              openPlayPlaylistQueue();
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
          },
        ),
      ),
    );
  }

  void openPlayPlaylistQueue(){
Navigator.push(
      context,
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (_, ___, __) => const PlayPlayListView(),
      ),
    );
  }
  void openDriverModel(){
      Navigator.push(
      context,
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (_, ___, __) => const DriverModeView(),
      ),
    );
  }
}
