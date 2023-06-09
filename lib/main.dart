import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:youtube/provider/provider.dart';
import 'package:youtube/provider/providerDatabase.dart';
import 'package:youtube/screens/homeScreen/mainPage.dart';
import 'package:youtube/screens/openYouTubeScreen.dart';


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
        OpenYouTube.routeName: (context) => const OpenYouTube(),
      },
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.dark,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
            systemOverlayStyle:  SystemUiOverlayStyle(
              systemNavigationBarColor: Colors.black26,
              statusBarColor: Colors.black26,
            ),
            ),
      ),
       )
    );
  }
}

///

// import 'package:flutter/material.dart';
// import 'package:miniplayer/miniplayer.dart';
//
// void main() => runApp(MyApp());
//
// final _navigatorKey = GlobalKey<NavigatorState>();
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Miniplayer example',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primaryColor: Color(0xFFFAFAFA),
//       ),
//       home: MyHomePage(),
//     );
//   }
// }
//
// class MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MiniplayerWillPopScope(
//       onWillPop: () async {
//         final NavigatorState? navigator = _navigatorKey.currentState;
//         if (!navigator!.canPop()) return true;
//         navigator.pop();
//
//         return false;
//       },
//       child: Scaffold(
//         body: Stack(
//           children: <Widget>[
//             Navigator(
//               key: _navigatorKey,
//               onGenerateRoute: (RouteSettings settings) => MaterialPageRoute(
//                 settings: settings,
//                 builder: (BuildContext context) => SecondScreen(),
//               ),
//             ),
//             Miniplayer(
//               minHeight: 70,
//               maxHeight: 370,
//               builder: (height, percentage) => Center(
//                 child: Text('$height, $percentage'),
//               ),
//             ),
//           ],
//         ),
//         bottomNavigationBar: BottomNavigationBar(
//           currentIndex: 0,
//           fixedColor: Colors.blue,
//           items: [
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home),
//               label: 'Home',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.mail),
//               label: 'Messages',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.person),
//               label: 'Profile',
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class FirstScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Demo: FirstScreen')),
//       body: Container(
//         constraints: BoxConstraints.expand(),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: () => Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => SecondScreen()),
//               ),
//               child: const Text('Open SecondScreen'),
//             ),
//             ElevatedButton(
//               onPressed: () => Navigator.of(context, rootNavigator: true).push(
//                 MaterialPageRoute(builder: (context) => ThirdScreen()),
//               ),
//               child: const Text('Open ThirdScreen with root Navigator'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class SecondScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Demo: SecondScreen')),
//       body: Center(child: Text('SecondScreen')),
//     );
//   }
// }
//
// class ThirdScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Demo: ThirdScreen')),
//       body: Center(child: Text('ThirdScreen')),
//     );
//   }
// }