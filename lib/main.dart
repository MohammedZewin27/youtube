

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:youtube/provider.dart';

import 'package:youtube/videoScreen.dart';


import 'mainPage.dart';

void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => VideoProvider(),
        ),
      ],
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'YouTube',
initialRoute: MainPage.routeName,
      routes: {
        MainPage.routeName:(context) => const MainPage(),
        VideoScreen.routeName:(context) => const VideoScreen(),

      },
theme:ThemeData(
  brightness: Brightness.dark,
  bottomNavigationBarTheme:const BottomNavigationBarThemeData(
selectedItemColor: Colors.white,
  ),
) ,
    );
  }
}

