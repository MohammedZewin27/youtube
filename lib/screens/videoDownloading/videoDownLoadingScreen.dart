import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube/provider/providerDatabase.dart';
import 'package:youtube/widgets/veiwVideo.dart';

import '../../generated/assets.dart';
import '../../res.dart';
import '../../widgets/custom_sliverAppBar.dart';
import '../openYouTubeScreen.dart';

class VideoDownLoadingScreen extends StatefulWidget {
  const VideoDownLoadingScreen({Key? key}) : super(key: key);

  @override
  State<VideoDownLoadingScreen> createState() => _VideoDownLoadingScreenState();
}

class _VideoDownLoadingScreenState extends State<VideoDownLoadingScreen> {
  @override
  Widget build(BuildContext context) {
    var videos = ProviderData.videos;
    var provider = Provider.of<ProviderData>(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            leadingWidth: 100,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                  onTap: () async {
                    await Navigator.pushNamed(context, OpenYouTube.routeName);
                  },
                  child: Image.asset(Assets.imageLogo)),
            ),
            actions: const [
             // Icon(Icons.signal_wifi_connected_no_internet_4_rounded),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Download"),
              )
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.only(bottom: 8),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  var video = videos[index];
                  var pathVideo = ProviderData.allVideos[index]['filePath'];
                  print(pathVideo);
                  return  ViewVideo(
                          video: video,
                          index: index,
                          pathVideo: pathVideo,
                        );
                },
                childCount: videos.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
