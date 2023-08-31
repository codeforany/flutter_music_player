import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

Future<AudioHandler> initAudioService() async {
  return await AudioService.init(
      builder: () => MyAudioHandler(),
      config: AudioServiceConfig(
        androidNotificationChannelId:
            "com.codeforany.music_player.channel.audio",
        androidNotificationChannelName: "music_player",
        androidNotificationIcon: "drawable/ic_stat_music_note",
        androidShowNotificationBadge: true,
        androidStopForegroundOnPause: true,
        notificationColor: Colors.grey[900],
      ));
}

abstract class AudioPlayerHandler implements AudioHandler {
  Future<void> setNewPlaylist(List<MediaItem> mediaItems, int index);
  Future<void> moveQueueItem(int currentIndex, int newIndex);
  Future<void> removeQueueItemIndex(int index);
}

class MyAudioHandler extends BaseAudioHandler implements AudioPlayerHandler {
  final player = AudioPlayer();
  final playlist =
      ConcatenatingAudioSource(children: [], useLazyPreparation: true);
  late List<int> preferredCompactNotificationButton = [1, 2, 3];

  MyAudioHandler() {
    loadEmptyPlaylist();
    notifyAudioHandlerAboutPlaybackEvents();
    listenForDurationChanges();
    listenForCurrentSongIndexChanges();
    listenForSequenceStateChanges();
  }

  Future<void> loadEmptyPlaylist() async {
    try {
      preferredCompactNotificationButton = [0, 1, 2];
      await player.setAudioSource(playlist);
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> notifyAudioHandlerAboutPlaybackEvents() async {
    player.playbackEventStream.listen((event) {
      final playing = player.playing;
      playbackState.add(PlaybackState(
        controls: [
          MediaControl.skipToPrevious,
          if (playing) MediaControl.pause else MediaControl.play,
          MediaControl.stop,
          MediaControl.skipToNext,
        ],
        systemActions: const {MediaAction.seek},
        androidCompactActionIndices: const [0, 1, 3],
        processingState: const {
          ProcessingState.idle: AudioProcessingState.idle,
          ProcessingState.loading: AudioProcessingState.loading,
          ProcessingState.buffering: AudioProcessingState.buffering,
          ProcessingState.ready: AudioProcessingState.ready,
          ProcessingState.completed: AudioProcessingState.completed,
        }[player.processingState]!,
        repeatMode: const {
          LoopMode.off: AudioServiceRepeatMode.none,
          LoopMode.one: AudioServiceRepeatMode.one,
          LoopMode.all: AudioServiceRepeatMode.all,
        }[player.loopMode]!,
        shuffleMode: player.shuffleModeEnabled
            ? AudioServiceShuffleMode.all
            : AudioServiceShuffleMode.none,
        playing: playing,
        updatePosition: player.position,
        bufferedPosition: player.bufferedPosition,
        speed: player.speed,
        queueIndex: event.currentIndex,
      ));
    });
  }

  Future<void> listenForDurationChanges() async {
    player.durationStream.listen((duration) {
      var index = player.currentIndex;
      final newQueue = queue.value;
      if (index == null || newQueue.isEmpty || newQueue.length < index) return;
      if (player.shuffleModeEnabled) {
        index = player.shuffleIndices!.indexOf(index);
      }
      final oldMediaItem = newQueue[index];
      final newMediaItem = oldMediaItem.copyWith(duration: duration);
      newQueue[index] = newMediaItem;
      queue.add(newQueue);
      mediaItem.add(newMediaItem);
    });
  }

  Future<void> listenForCurrentSongIndexChanges() async {
    player.currentIndexStream.listen((index) {
      final pPlaylist = queue.value;
      if (index == null || pPlaylist.isEmpty) return;
      if (player.shuffleModeEnabled) {
        index = player.shuffleIndices!.indexOf(index);
      }
      mediaItem.add(pPlaylist[index]);
    });
  }

  Future<void> listenForSequenceStateChanges() async {
    player.sequenceStateStream.listen((sequenceState) {
      final sequence = sequenceState?.effectiveSequence;
      if (sequence == null || sequence.isEmpty) return;
      final items = sequence.map((source) => source.tag as MediaItem);
      queue.add(items.toList());
    });
  }

  @override
  Future<void> addQueueItem(MediaItem mediaItem) async {
    final audioSource = createAudioSource(mediaItem);
    await playlist.add(audioSource);
    final newQueue = queue.value..add(mediaItem);
    queue.add(newQueue);
  }

  @override
  Future<void> addQueueItems(List<MediaItem> mediaItems) async {
    final audioSource = createAudioSources(mediaItems);
    await playlist.addAll(audioSource);
    final newQueue = queue.value..addAll(mediaItems);
    queue.add(newQueue);
  }

  @override
  Future<void> updateMediaItem(MediaItem mediaItem) async {
    final index = queue.value.indexWhere((item) => item.id == mediaItem.id);
    var dataArr = queue.value;
    dataArr[index] = mediaItem;
    queue.add(dataArr);
  }

  @override
  Future<void> updateQueue(List<MediaItem> queue) async {
    await playlist.clear();
    await playlist.addAll(createAudioSources(queue));
  }

  UriAudioSource createAudioSource(MediaItem mediaItem) {
    return AudioSource.uri(Uri.parse(mediaItem.extras!['url'] as String),
        tag: mediaItem);
  }

  List<UriAudioSource> createAudioSources(List<MediaItem> mediaItems) {
    return mediaItems
        .map((item) => AudioSource.uri(Uri.parse(item.extras!['url'] as String),
            tag: item))
        .toList();
  }

  @override
  Future<void> removeQueueItemAt(int index) async {
    await playlist.removeRange(0, index);
    final newQueue = queue.value..clear();
    queue.add(newQueue);
  }

  @override
  Future<void> play() async {
    await player.play();
  }

  @override
  Future<void> pause() async {
    await player.pause();
  }

  @override
  Future<void> seek(Duration position) async {
    player.seek(position);
  }

  @override
  Future<void> skipToQueueItem(int index) async {
    if (index < 0 || index >= queue.value.length) return;
    if (player.shuffleModeEnabled) {
      index = player.shuffleIndices![index];
    }
    player.seek(Duration.zero, index: index);
  }

  @override
  Future<void> skipToNext() async {
     player.seekToNext();
  }

  @override
  Future<void> skipToPrevious() async {
     player.seekToPrevious();
  }

  @override
  Future<void> setRepeatMode(AudioServiceRepeatMode repeatMode) async {
    switch (repeatMode) {
      case AudioServiceRepeatMode.none:
        player.setLoopMode(LoopMode.off);
        break;
      case AudioServiceRepeatMode.one:
        player.setLoopMode(LoopMode.one);
        break;
      case AudioServiceRepeatMode.group:
      case AudioServiceRepeatMode.all:
        player.setLoopMode(LoopMode.all);
        break;
    }
  }

  @override
  Future<void> setShuffleMode(AudioServiceShuffleMode shuffleMode) async {
    if (shuffleMode == AudioServiceShuffleMode.none) {
      player.setShuffleModeEnabled(false);
    } else {
      player.shuffle();
      player.setShuffleModeEnabled(true);
    }
  }

  @override
  Future customAction(String name, [Map<String, dynamic>? extras]) async {
    if(name == 'dispose') {
      await player.dispose();
      super.stop();
    }
  }

  @override
  Future<void> stop() async {
    await player.stop();
    playbackState.add( playbackState.value.copyWith(processingState: AudioProcessingState.idle) );
    return super.stop();
  }

  @override
  Future<void> moveQueueItem(int currentIndex, int newIndex) async {
    await playlist.move(currentIndex, newIndex);
  }

  @override
  Future<void> removeQueueItemIndex(int index) async {
    await playlist.removeAt(index);
  }

  @override
  Future<void> setNewPlaylist(List<MediaItem> mediaItems, int index) async {
    if (!Platform.isAndroid) {
      await player.stop();
    }

    var getCount = queue.value.length;
    await playlist.removeRange(0, getCount);
    final audioSource = createAudioSources(mediaItems);
    await playlist.addAll(audioSource);
    final newQueue = queue.value..addAll(mediaItems);
    queue.add(newQueue);
    await player.setAudioSource(playlist,
        initialIndex: index, initialPosition: Duration.zero);
  }
}
