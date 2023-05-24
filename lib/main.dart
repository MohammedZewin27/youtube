import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:youtube/provider/provider.dart';
import 'package:youtube/provider/providerDatabase.dart';
import 'package:youtube/screens/homeScreen/mainPage.dart';


import 'package:youtube/screens/videoView/videoScreen.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => ProviderData()..createDatabase(),
    ),
    ChangeNotifierProvider(
      create: (context) => VideoProvider(),
    ),

  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Provider.of<ProviderData>(context);
    return Shortcuts(
        shortcuts: <LogicalKeySet, Intent>{
        LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
        },

       child:  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'YouTube',
      initialRoute: MainPage.routeName,
      routes: {
        MainPage.routeName: (context) => const MainPage(),
        VideoScreen.routeName: (context) => const VideoScreen(),
      },
      theme: ThemeData(
        brightness: Brightness.dark,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
            systemOverlayStyle:  SystemUiOverlayStyle(
              // systemNavigationBarColor: Colors.black,
              statusBarColor: Colors.black,
            ),
            ),
      ),
       )
    );
  }
}
