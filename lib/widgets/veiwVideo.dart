

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../provider/providerDatabase.dart';

class ViewVideo extends StatefulWidget {
final String pathVideo;
final MyVideo video;
final int index;
  ViewVideo({required this.pathVideo,required this.video, required this.index});

  @override
  State<ViewVideo> createState() => _ViewVideoState();
}

class _ViewVideoState extends State<ViewVideo> {
  late VideoPlayerController controllerVideoDownload;
  bool playOrPause = false;
  bool sound = false;

  void initState() {
    // TODO: implement initState
    super.initState();
    controllerVideoDownload = VideoPlayerController.file(
        File(widget.pathVideo))
      ..initialize().then((value) {
        setState(() {});
      });
  }
  @override
  void dispose() {
    controllerVideoDownload.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            InkWell(
              onTap: () {
                !playOrPause
                    ? controllerVideoDownload.play()
                    : controllerVideoDownload.pause();
                setState(() {
                  playOrPause = !playOrPause;
                });
              },
              child: Center(
                child: controllerVideoDownload.value.isInitialized
                    ? AspectRatio(
                  aspectRatio:
                 controllerVideoDownload.value.aspectRatio,
                  child: VideoPlayer(controllerVideoDownload),
                )
                    : Container(),
              ),
            ),
            playOrPause
                ? const Icon(Icons.pause, color: Colors.grey)
                : const Icon(Icons.play_arrow, color: Colors.grey),
            Positioned(
              bottom: 0,
              right: 0,
              child: MaterialButton(
                onPressed: () async {
                  controllerVideoDownload.setVolume(sound ? 1 : 0);
                  setState(() {
                    sound = !sound;
                  });
                },
                child: sound
                    ? const Icon(Icons.volume_off_rounded, color: Colors.grey)
                    : const Icon(Icons.volume_up, color: Colors.grey),
              ),
            ),
          ],
        ),
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CircleAvatar(
            foregroundImage: NetworkImage(widget.video.image),
          ),
          const SizedBox(
            width: 30,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                    child: Text(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      '   ${widget.video.title}  | '
                          ' ${widget.video.duration} |  '
                          ' ${widget.video.publishDate.substring(0, 11)}',
                      style: const TextStyle(fontSize: 15),
                    )),
              ],
            ),
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_vert,
                size: 20,
              )),
        ]),
      ],
    );
  }
}
