import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:youtube/provider/providerDatabase.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import '../../models/data.dart';

class DownloadScreen extends StatefulWidget {
  const DownloadScreen({Key? key}) : super(key: key);

  @override
  State<DownloadScreen> createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  final TextEditingController urlTextEditingController =
      TextEditingController();
  String videoTitle = '';
  String videoPublishDate = '';
  String videoId = '';
  bool downloading = false;

  double progress = 0.0;
  var pathFileInMyPhone;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: urlTextEditingController,
                onChanged: (value) async {
                  await getVideoInfo(value);
                },
                decoration: const InputDecoration(
                  label: Text('past youtube video url Here'),
                ),
              ),
            ),
            videoId != '' && videoId.length > 10
                ? Image.network(
                    'https://img.youtube.com/vi/$videoId/0.jpg',
                    height: 250,
                  )
                : Container(),
            Text(videoTitle),
            Text(videoPublishDate),
            TextButton.icon(
              onPressed: () async {
                await downloadVideo(urlTextEditingController.text)
                    .then((value) {});
              },
              label: videoId != '' && videoId.length > 10
                  ? const Text('download')
                  : const Text(''),
              icon: videoId != '' && videoId.length > 10
                  ? const Icon(Icons.download)
                  : const Text(''),
            ),
            TextButton.icon(
              onPressed: () async {
                await insertVideoInDatabase(urlTextEditingController.text);
              },
              label: videoId != '' && videoId.length > 10
                  ? const Text('insert')
                  : const Text(''),
              icon: videoId != '' && videoId.length > 10
                  ? const Icon(Icons.download)
                  : const Text(''),
            ),
            downloading
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.blueAccent,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                          Colors.greenAccent),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  Future<void> getVideoInfo(url) async {
    try {
      var videoInfo = YoutubeExplode();
      var video = await videoInfo.videos.get(url);
      setState(() {
        videoTitle = video.title;
        videoPublishDate = video.publishDate.toString().substring(0, 11);
        videoId = video.id.toString();
      });
    } catch (e) {
      print('======= $e');
    }
  }

  Future<void> downloadVideo(url) async {
    var permisson = await Permission.storage.request();
    if (permisson.isGranted) {
      //download video
      if (urlTextEditingController.text != '') {
        setState(() => downloading = true);
        //download video
        setState(() => progress = 0);
        var youtubeExplode = YoutubeExplode();
        //get video metadata
        var videoDownload = await youtubeExplode.videos.get(url);
        var manifest =
            await youtubeExplode.videos.streamsClient.getManifest(url);
        var streams = manifest.muxed.withHighestBitrate();
        var audio = streams;
        var audioStream = youtubeExplode.videos.streamsClient.get(audio);
        //create a directory
        Directory appDocDir = await getApplicationDocumentsDirectory();
        String appDocPath = appDocDir.path;

        var filePath = File('$appDocPath/${videoDownload.id}');
        //delete filePath if exists
        if (filePath.existsSync()) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
            '  video exist!',
            style: TextStyle(color: Colors.red),
          )));
          setState(() {
            downloading = false;
          });
          return;
          // filePath.deleteSync();
        }
        var output = filePath.openWrite(mode: FileMode.writeOnlyAppend);
        var size = audio.size.totalBytes;
        var count = 0;

        await for (final data in audioStream) {
          // Keep track of the current downloaded data.
          count += data.length;
          // Calculate the current progress.
          double val = ((count / size));
          var msg =
              '${videoDownload.title} Downloaded to $appDocPath/${videoDownload.id}';

          for (val; val == 1.0; val++) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content:
                    Text(msg, style: const TextStyle(color: Colors.green))));
          }
          setState(() => progress = val);

          output.add(data);
        }
        /// add to database
        await insertVideoInDatabase(urlTextEditingController.text);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('add youtube video url first!',
                style: TextStyle(color: Colors.red))));
        setState(() => downloading = false);
      }
    } else {
      await Permission.storage.request();
    }
  }

  Future<void> insertVideoInDatabase(String url) async {
    var video = Provider.of<ProviderData>(context, listen: false);
    var youtubeExplode = YoutubeExplode();
    var videoInfo = await youtubeExplode.videos.get(url);
    var videoId = await videoInfo.id;
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    var myVideo = MyVideo(
        videoId: videoId.value.toString(),
        image: 'https://img.youtube.com/vi/$videoId/0.jpg',
        title: videoInfo.title,
        thumbnailUrl: videoInfo.url,
        duration: videoInfo.duration.toString().substring(2, 7),
        publishDate: videoInfo.publishDate.toString().substring(0, 11),
        filePath: '$appDocPath/${videoInfo.id}');

    video.insertDatabase(myVideo: myVideo);
  }
}
