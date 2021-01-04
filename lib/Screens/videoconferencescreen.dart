import 'package:calling_app/variables.dart';
import 'package:calling_app/videoConference/joinmeeting.dart';
import 'package:flutter/material.dart';

class VideoConferenceScreen extends StatefulWidget {
  @override
  _VideoConferenceScreenState createState() => _VideoConferenceScreenState();
}

class _VideoConferenceScreenState extends State<VideoConferenceScreen>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  buildtab(String name) {
    return Container(
      width: 150,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            name,
            style: mystyle(15, Colors.white),
          ),
        ],
      ),
    );
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        centerTitle: true,
        title: Text(
          "H Meetings",
         
        ),
      ),
      body: JoinMeeting(),
    );
  }
}
