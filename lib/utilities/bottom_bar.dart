// import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
// import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
// import 'package:fit_app/pages/chat/chat.dart';
// import 'package:fit_app/pages/home/home.dart';
// import 'package:fit_app/pages/profile/profile.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:fit_app/utilities/bottom_navigation_bar_height_provider.dart';

// class MyBottomNavigationBar extends StatefulWidget {
//   final int activeIndex;

//   const MyBottomNavigationBar({Key? key, required this.activeIndex})
//       : super(key: key);

//   @override
//   State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
// }

// class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
//   late int _selectedIndex; // Initialize as late int
//   final GlobalKey _bottomNavigationKey = GlobalKey();

//   @override
//   void initState() {
//     super.initState();
//     _selectedIndex =
//         widget.activeIndex; // Initialize _selectedIndex with activeIndex
//   }

//   double _getBottomNavigationBarHeight() {
//     final RenderBox renderBox =
//         _bottomNavigationKey.currentContext!.findRenderObject() as RenderBox;
//     return renderBox.size.height;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CurvedNavigationBar(
//       key: _bottomNavigationKey,
//       animationDuration: Duration(milliseconds: 300),
//       backgroundColor: Theme.of(context).colorScheme.background,
//       color: Color.fromARGB(255, 8, 31, 92),
//       index: _selectedIndex,
//       items: [
//         CurvedNavigationBarItem(
//           child: Icon(
//             Icons.home,
//             color: Theme.of(context).colorScheme.background,
//           ),
//           // label: 'Home',
//         ),
//         CurvedNavigationBarItem(
//           child: Icon(
//             Icons.fitness_center,
//             color: Theme.of(context).colorScheme.background,
//           ),
//           // label: 'Search',
//         ),
//         CurvedNavigationBarItem(
//           child: Icon(
//             Icons.message,
//             color: Theme.of(context).colorScheme.background,
//           ),
//           // label: 'Chat',
//         ),
//         CurvedNavigationBarItem(
//           child: Icon(
//             Icons.person,
//             color: Theme.of(context).colorScheme.background,
//           ),
//           // label: 'Feed',
//         ),
//       ],
//       onTap: (index) {
//         if (index == 0) {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => Home(),
//             ),
//           );
//         } else if (index == 2) {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => ChatPage(),
//             ),
//           );
//         } else if (index == 3) {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => ProfilePage(),
//             ),
//           );
//         }
//       },
//     );
//   }
// }
