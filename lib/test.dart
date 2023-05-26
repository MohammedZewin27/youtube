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
//                 builder: (BuildContext context) => FirstScreen(),
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