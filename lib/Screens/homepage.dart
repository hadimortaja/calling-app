import 'package:calling_app/Screens/profilescreen.dart';
import 'package:calling_app/Screens/videoconferencescreen.dart';
import 'package:flutter/material.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final tabs = [
    VideoConferenceScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[250],
       bottomNavigationBar: TitledBottomNavigationBar(
         currentIndex: _currentIndex,
         activeColor: Colors.greenAccent,
          onTap: (index) => setState(
            () {
              _currentIndex = index;
            },
       ),
       items: [
         TitledNavigationBarItem(title: Text('Video Call',style: TextStyle(fontWeight: FontWeight.w600),), icon: Icons.video_call),
                  TitledNavigationBarItem(title: Text('Profile',style: TextStyle(fontWeight: FontWeight.w600),), icon: Icons.person),

       ],
       ),
      body: tabs[_currentIndex],
    );
  }
}
