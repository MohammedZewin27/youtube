import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoDownLoadingScreen extends StatefulWidget {
  const VideoDownLoadingScreen({Key? key}) : super(key: key);

  @override
  State<VideoDownLoadingScreen> createState() => _VideoDownLoadingScreenState();
}

class _VideoDownLoadingScreenState extends State<VideoDownLoadingScreen> {
  late VideoPlayerController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // controller=VideoPlayerController.file(Fil)..initialize().then((value) {
    //   setState(() {
    //
    //   });
    // });
  }
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
