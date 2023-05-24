import 'package:flutter/material.dart';
import 'package:pip_view/pip_view.dart';
import 'package:youtube/screens/homeScreen/home_page.dart';
import 'package:youtube/models/data.dart';
import 'package:youtube/provider/provider.dart';
import 'package:youtube/provider/providerDatabase.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../homeScreen/mainPage.dart';


class VideoScreen extends StatefulWidget {
  const VideoScreen({Key? key}) : super(key: key);
  static const String routeName = 'videoScreen';

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late YoutubePlayerController controller;
  late final bool mute;
  late YoutubePlayerController _controller;
  late TextEditingController idController;
  late TextEditingController _seekToController;

  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = YoutubePlayerController(
      initialVideoId: ProviderData.allVideos[VideoProvider.selectVideo]
          ['videoId'],

      flags: const YoutubePlayerFlags(

        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    idController = TextEditingController();
    _seekToController = TextEditingController();
    _videoMetaData = const YoutubeMetaData();
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  // @override
  // void deactivate() {
  //   // Pauses video while navigating to next page.
  //   controller.pause();
  //   super.deactivate();
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PIPView(
      builder: (context, isFloating) => Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                color: Colors.black,
                child: Center(
                  child: YoutubePlayerBuilder(
                    player: YoutubePlayer(controller: controller),
                    onEnterFullScreen: () {
                      PIPView.of(context)?.presentBelow(MainPage());
                    },
                    onExitFullScreen: () {

                    },
                    builder: (context, player) {
                      return YoutubePlayer(controller: controller);
                    },
                  ),
                ),
              ),
              Text(idController.text = ProviderData
                  .allVideos[VideoProvider.selectVideo]['videoTitle']),
              MaterialButton(
                  child: Icon(Icons.volume_mute),
                  onPressed: () {
                    PIPView.of(context)?.presentBelow(MainPage());
                    setState(() {});
                  }),
            ],
          ),
        ),
      ),
    );
  }

  /// FUNCTION CONVERT LINK YOUTUBE TO GET ID ONLY BUT I DON'T USE IT
  String convertedUrlYoutube(url) {
    return YoutubePlayer.convertUrlToId(url).toString();
  }
}
