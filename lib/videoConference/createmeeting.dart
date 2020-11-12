import 'package:calling_app/variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:uuid/uuid.dart';

class CreateMeeting extends StatefulWidget {
  @override
  _CreateMeetingState createState() => _CreateMeetingState();
}

class _CreateMeetingState extends State<CreateMeeting> {
  String code = '';
  createCode() {
    setState(() {
      code = Uuid().v1().substring(0, 6);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 100),
            child: Text(
              "Create Code and share it with your friends",
              style: mystyle(20),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Code: ",
                style: mystyle(20, Colors.black, FontWeight.bold),
              ),
              SizedBox(width: 10,),
              Text(
                code,
                style: mystyle(20),
              ),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          InkWell(
            onTap: () => createCode(),
            child: Container(
                width: MediaQuery.of(context).size.width / 2,
                height: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient:
                        LinearGradient(colors: GradientColors.juicyOrange)),
                child: Center(
                  child: Text(
                    "Create Code  ",
                    style: mystyle(
                      20,
                      Colors.white,
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
