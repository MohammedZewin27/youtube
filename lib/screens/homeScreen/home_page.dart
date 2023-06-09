import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube/provider/providerDatabase.dart';
import 'package:youtube/widgets/custom_sliverAppBar.dart';
import 'package:youtube/widgets/video_card.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProviderData>(context);
    var videos = ProviderData.videos;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const CustomSliverAppBar(),
          SliverPadding(
            padding: const EdgeInsets.only(bottom: 8),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  var video = videos[index];
                  return VideoCard(video: video, index: index);
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
