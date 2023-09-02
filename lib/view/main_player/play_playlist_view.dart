import 'dart:math';

import 'package:audio_service/audio_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/audio_helpers/page_manager.dart';
import 'package:music_player/audio_helpers/service_locator.dart';
import 'package:music_player/common_widget/playlist_song_row.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../../common/color_extension.dart';

class PlayPlayListView extends StatefulWidget {
  const PlayPlayListView({super.key});

  @override
  State<PlayPlayListView> createState() => _PlayPlayListViewState();
}

class _PlayPlayListViewState extends State<PlayPlayListView> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    final pageManager = getIt<PageManager>();
    return Dismissible(
      key: const Key("playlistScreen"),
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
            "Playlist",
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
                onSelected: (selectIndex) {},
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Hero(
                              tag: "currentArtWork",
                              child: ValueListenableBuilder(
                                valueListenable:
                                    pageManager.currentSongNotifier,
                                builder: (context, value, child) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        media.width * 0.4),
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
                                      width: media.width * 0.4,
                                      height: media.width * 0.4,
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
                                width: media.width * 0.41,
                                height: media.width * 0.41,
                                child: SleekCircularSlider(
                                  appearance: CircularSliderAppearance(
                                      customWidths: CustomSliderWidths(
                                          trackWidth: 2,
                                          progressBarWidth: 4,
                                          shadowWidth: 6),
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
                                      valueState.total.inMilliseconds
                                          .toDouble()),
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
                    style: TextStyle(color: TColor.primaryText80, fontSize: 12),
                  ),
                  Expanded(
                    child: ValueListenableBuilder(
                      valueListenable: pageManager.playlistNotifier,
                      builder: (context, queue, __) {
                        final int queueStateIndex =
                            pageManager.currentSongNotifier.value == null
                                ? 0
                                : queue.indexOf(
                                    pageManager.currentSongNotifier.value!);

                        final num queuePosition =
                            queue.length - queueStateIndex;

                        return Theme(
                          data: Theme.of(context).copyWith(
                              canvasColor: Colors.transparent,
                              shadowColor: Colors.transparent),
                          child: ReorderableListView.builder(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              itemCount: queue.length,
                              onReorder: (oldIndex, newIndex) {
                                if (oldIndex < newIndex) {
                                  newIndex--;
                                }
                                pageManager.moveMediaItem(oldIndex, newIndex);
                              },
                              itemBuilder: (context, index) {
                                var sObj = queue[index];

                                return Dismissible(
                                  key: ValueKey(sObj.id),
                                  direction: index == queue
                                      ? DismissDirection.none
                                      : DismissDirection.horizontal,
                                  onDismissed: (direction) {
                                    pageManager.removeQueueItemAt(index);
                                  },
                                  child: PlaylistSongRow(
                                    sObj: sObj,
                                    right: (index == queueStateIndex)
                                        ? Icon(
                                            Icons.bar_chart_rounded,
                                            color: TColor.primary,
                                          )
                                        : ReorderableDragStartListener(
                                            key: Key(sObj.id),
                                            enabled: index != queueStateIndex,
                                            index: index,
                                            child: Icon(
                                              Icons.drag_handle_rounded,
                                              color: TColor.primaryText,
                                            ),
                                          ),
                                    onPressed: () {
                                      pageManager.skipToQueueItem(index);
                                      if (pageManager
                                              .playButtonNotifier.value ==
                                          ButtonState.paused) {
                                        pageManager.play();
                                      }
                                    },
                                  ),
                                );
                              }),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
