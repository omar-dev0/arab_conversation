import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class Controllers extends StatelessWidget {
  final AudioPlayer audioPlayer;
  const Controllers({super.key, required this.audioPlayer});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlayerState>(
        stream: audioPlayer.playerStateStream,
        builder: (context, snapshot) {
          final playState = snapshot.data;
          final processingState = playState?.processingState;
          final playingState = playState?.playing;
          if (!(playingState ?? false)) {
            return InkWell(
              onTap: audioPlayer.play,
              child: const Icon(
                Icons.play_circle_fill_rounded,
                color: Colors.white,
                size: 50,
              ),
            );
          } else if (processingState != ProcessingState.completed) {
            return InkWell(
              onTap: audioPlayer.pause,
              child: const Icon(
                Icons.pause_circle_filled_rounded,
                color: Colors.white,
                size: 50,
              ),
            );
          }
          return const Icon(
            Icons.play_circle_fill_rounded,
            color: Colors.white,
            size: 50,
          );
        });
  }
}
