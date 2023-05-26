import 'package:flutter/material.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:provider/provider.dart';
import 'package:youtube/screens/homeScreen/home_page.dart';
import 'package:youtube/screens/videoDownloading/download_secreen.dart';
import 'package:youtube/screens/videoView/videoScreen.dart';
import '../../provider/provider.dart';
import '../videoDownloading/videoDownLoadingScreen.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  static const String routeName = 'MainPage';

  @override
  State<MainPage> createState() => _MainPageState();
}

final screens = [
  const HomePage(),
  const DownloadScreen(),
  const VideoDownLoadingScreen(),
];

int selectIndex = 0;

class _MainPageState extends State<MainPage> {
  final ValueNotifier<double> playerExpandProgress = ValueNotifier(70);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<VideoProvider>(context);
    return Scaffold(
        bottomNavigationBar: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              provider.mini
                  ? Miniplayer(

                      valueNotifier: playerExpandProgress,
                       minHeight: 70,
                       maxHeight:370,
                      builder: (height, percentage) {
                        return VideoScreen();
                      },
                    )
                  : Container(),
              BottomNavigationBar(
                  onTap: (index) {
                    selectIndex = index;
                    setState(() {});
                  },
                  currentIndex: selectIndex,
                  type: BottomNavigationBarType.fixed,
                  selectedFontSize: 10.0,
                  unselectedFontSize: 10.0,
                  items: const [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home_outlined),
                        label: 'home',
                        activeIcon: Icon(Icons.home)),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.download_for_offline_outlined),
                        label: 'download',
                        activeIcon: Icon(Icons.download_for_offline_rounded)),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.video_call_outlined),
                        label: 'video',
                        activeIcon: Icon(Icons.video_call_rounded)),
                  ]),
            ],
          ),
        ),
        body: Stack(
          children: screens
              .asMap()
              .map((index, screen) => MapEntry(
                  index,
                  Offstage(
                    offstage: selectIndex != index,
                    child: screen,
                  )))
              .values
              .toList(),
        ));
  }
}
