
import 'package:flutter/material.dart';

import 'package:miniplayer/miniplayer.dart';
import 'package:pip_view/pip_view.dart';
import 'package:provider/provider.dart';
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
  bool mute =false;
  late TextEditingController idController;
  bool isFull = false;



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
        hideControls: false,
      ),
    );


  }

  @override
  void dispose() async{
    // TODO: implement dispose
    super.dispose();


  }


  final ValueNotifier<double> playerExpandProgress = ValueNotifier(70);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<VideoProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:
          // Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   // mainAxisSize: MainAxisSize.min,
          //   children: [
          Row(
        children: [
          Expanded(
            child: Container(
              height: 250,
              width: 300,
              color: Colors.white,
              child: YoutubePlayerBuilder(
                player: YoutubePlayer(controller: controller,
                onEnded: (metaData) {
                  controller.dispose();
                },
                ),
                builder: (context, player) {
                  return Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      IconButton(
                          onPressed: () {}, icon: Icon(Icons.play_arrow)),
                      Expanded(child: Container()),
                      player,
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// FUNCTION CONVERT LINK YOUTUBE TO GET ID ONLY BUT I DON'T USE IT
  String convertedUrlYoutube(url) {
    return YoutubePlayer.convertUrlToId(url).toString();
  }


}
