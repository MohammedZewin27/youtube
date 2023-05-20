import 'dart:io';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

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
                await downloadVideo(urlTextEditingController.text);
              },
              label: videoId != '' && videoId.length > 10
                  ? const Text('download')
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

  Future<void> downloadVideo(id) async {
    var permisson = await Permission.storage.request();
    if (permisson.isGranted) {
      //download video
      if (urlTextEditingController.text != '') {
        setState(() => downloading = true);
        //download video
        setState(() => progress = 0);
        var _youtubeExplode = YoutubeExplode();
        //get video metadata
        var videoDownload = await _youtubeExplode.videos.get(id);
        var manifest =
            await _youtubeExplode.videos.streamsClient.getManifest(id);
        var streams = manifest.muxed.withHighestBitrate();
        var audio = streams;
        var audioStream = _youtubeExplode.videos.streamsClient.get(audio);
        //create a directory
        Directory appDocDir = await getApplicationDocumentsDirectory();
        String appDocPath = appDocDir.path;
        var file = File('$appDocPath/${videoDownload.id}');
        //delete file if exists
        if (file.existsSync()) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('  video exist!')));
          setState(() => downloading = false);
          return;
          // file.deleteSync();
        }
        var output = file.openWrite(mode: FileMode.writeOnlyAppend);
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
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(msg)));
          }
          setState(() => progress = val);

          /// ADD TO DATABASE



          // Write to file.
          output.add(data);
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('add youtube video url first!')));
        setState(() => downloading = false);
      }
    } else {
      await Permission.storage.request();
    }
  }
}
