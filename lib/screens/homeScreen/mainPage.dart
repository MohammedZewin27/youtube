import 'package:flutter/material.dart';
import 'package:youtube/screens/homeScreen/home_page.dart';
import 'package:youtube/screens/videoDownloading/download_secreen.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
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
