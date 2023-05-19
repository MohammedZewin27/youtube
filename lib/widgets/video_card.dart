
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube/data.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:youtube/mainPage.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube/provider.dart';
import 'package:youtube/videoScreen.dart';
class VideoCard extends StatelessWidget {
  final Video video;
  final int index;

  const VideoCard({Key? key, required this.video,required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
var arg=Provider.of<VideoProvider>(context);
    return GestureDetector(
      onTap: () {
        // context.read(selectedVideoProvider).state=video;
        arg.changeSelect(index);
        print(video.title);
        print(videos[VideoProvider.selectVideo].id);
        print(index);
        Navigator.pushNamed(context, VideoScreen.routeName);
      },
      child: Column(
        children: [
          Stack(
            children: [
              Image.network(
                video.thumbnailUrl,
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                  bottom: 10,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    color: Colors.black,
                    child: Text(
                      video.duration,
                      style: TextStyle(),
                    ),
                  ))
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                foregroundImage: NetworkImage(video.channel.channelImageUrl),
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
                      video.title,
                      maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 15),
                    )),
                    Flexible(
                        child: Text(
                          maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      '${video.channel.channelName}  |  ${video.viewCount}  |  ${timeago.format(video.timestamp)}',
                      style: const TextStyle(fontSize: 15),
                    )),


                  ],
                ),
              ),
              Icon(Icons.more_vert,size: 20,)
            ],
          ),

        ],
      ),
    );
  }
}