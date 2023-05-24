import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pip_view/pip_view.dart';
import 'package:provider/provider.dart';


import 'package:timeago/timeago.dart' as timeago;

import 'package:youtube/provider/provider.dart';
import 'package:youtube/provider/providerDatabase.dart';
import 'package:youtube/screens/videoView/videoScreen.dart';

class VideoCard extends StatelessWidget {
  final MyVideo video;
  final int index;

  const VideoCard({Key? key, required this.video, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var arg = Provider.of<VideoProvider>(context);
    var data = Provider.of<ProviderData>(context);
    return Container(
        margin: EdgeInsets.only(left: 5, right: 10, top: 5),
        child: Slidable(
          startActionPane: ActionPane(
            motion: ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {
                  data.deleteRowInDatabase(
                      id: ProviderData.allVideos[index]['id']);
                },
                backgroundColor: Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'DELETE',
                borderRadius: BorderRadius.circular(8),
              ),
            ],
          ),
          child: GestureDetector(
            onTap: () {
              // context.read(selectedVideoProvider).state=video;
              arg.changeSelect(index);
              print(video.title);

              print(index);
              Navigator.pushNamed(context, VideoScreen.routeName);
            },
            child: Column(
              children: [
                Stack(
                  children: [
                    Image.network(
                      video.image,
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
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  CircleAvatar(
                    foregroundImage: NetworkImage(video.image),
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
                          '   ${video.title}  | '
                              ' ${video.duration} |  '
                              ' ${video.publishDate.substring(0, 11)}',
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
            ),
          ),
        ));
  }
}
