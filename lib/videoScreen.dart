import 'package:flutter/material.dart';
import 'package:youtube/models/data.dart';
import 'package:youtube/provider.dart';
import 'package:youtube/provider/providerDatabase.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

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
  late TextEditingController _idController;
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
      initialVideoId: ProviderData.allVideos[VideoProvider.selectVideo]['videoId'],
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
    _idController = TextEditingController();
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

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    controller.pause();
    super.deactivate();
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.black,
            child: Center(
              child: YoutubePlayerBuilder(
                player: YoutubePlayer(controller: controller),
                builder: (context, player) {
                  return YoutubePlayer(controller: controller);
                },
              ),
            ),
          ),
          MaterialButton(
              child: Icon(Icons.volume_mute),
              onPressed: () {
                YoutubePlayer(
                  controller: controller,
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: Colors.amber,
                  progressColors: const ProgressBarColors(
                    playedColor: Colors.amber,
                    handleColor: Colors.amberAccent,
                  ),
                  onReady: () {},
                );

                setState(() {});
              }),
        ],
      ),
    );
  }

  /// FUNCTION CONVERT LINK YOUTUBE TO GET ID ONLY
  String convertedUrlYoutube(url) {
    return YoutubePlayer.convertUrlToId(url).toString();
  }
}
