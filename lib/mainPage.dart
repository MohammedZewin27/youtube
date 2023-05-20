import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube/data.dart';
import 'package:youtube/download_secreen.dart';
import 'package:youtube/home_page.dart';


// final selectedVideoProvider=StateProvider<Video?>((ref)=>null);

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  static const String routeName = 'MainPage';

  @override
  State<MainPage> createState() => _MainPageState();
}

final screens = [
  const HomePage(),
  const Scaffold(
    body: Center(child: Text('Explore Screen')),
  ),
  const DownloadScreen(),
  const Scaffold(
    body: Center(child: Text('Subscriptions Screen')),
  ),
  const Scaffold(
    body: Center(child: Text('Library Screen')),
  ),
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
                  icon: Icon(Icons.explore_outlined),
                  label: 'Explore',
                  activeIcon: Icon(Icons.explore)),
              BottomNavigationBarItem(
                  icon: Icon(Icons.download_for_offline_outlined),
                  label: 'download',
                  activeIcon: Icon(Icons.download_for_offline_rounded)),
              BottomNavigationBarItem(
                  icon: Icon(Icons.subscriptions_outlined),
                  label: 'subscriptions',
                  activeIcon: Icon(Icons.subscriptions)),
              BottomNavigationBarItem(
                  icon: Icon(Icons.video_library_outlined),
                  label: 'library',
                  activeIcon: Icon(Icons.video_library)),
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
