import 'dart:io';
import 'package:calling_app/variables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:jitsi_meet/feature_flag/feature_flag_enum.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:uuid/uuid.dart';

class JoinMeeting extends StatefulWidget {
  @override
  _JoinMeetingState createState() => _JoinMeetingState();
}

class _JoinMeetingState extends State<JoinMeeting> {
  TextEditingController nameController = TextEditingController();
  TextEditingController roomController = TextEditingController();

  bool isVideoMuted = true;
  bool isAudioMuted = true;
  String username = '';
  String code = '';
  bool dataisthere = false;

  @override
  void initState() {
    super.initState();
    getuserdata();
  }

  getuserdata() async {
    DocumentSnapshot userdoc =
        await userCollection.doc(FirebaseAuth.instance.currentUser.uid).get();
    setState(() {
      username = userdoc.data()['username'];
      dataisthere = true;
    });
  }

  joinmeeting() async {
    try {
      Map<FeatureFlagEnum, bool> featureflags = {
        FeatureFlagEnum.WELCOME_PAGE_ENABLED: false
      };
      if (Platform.isAndroid) {
        featureflags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
      } else if (Platform.isIOS) {
        featureflags[FeatureFlagEnum.PIP_ENABLED] = false;
      }
      var options = JitsiMeetingOptions()
        ..room = roomController.text
        ..userDisplayName =
            nameController.text == '' ? username : nameController.text
        ..audioMuted = isAudioMuted
        ..videoMuted = isVideoMuted
        ..featureFlags.addAll(featureflags);

      await JitsiMeet.joinMeeting(options);
    } catch (e) {
      print("Error : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: dataisthere == false
          ? Center(child: CupertinoActivityIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Text(
                      'Welcome $username :)',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Text(
                      "Create Code and share it with your friends",
                      style: TextStyle(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Meeting Code: ",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.green,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey)),
                        child: SelectableText(
                          code = Uuid().v1().substring(0, 4),
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Add Meeting Code",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 40, right: 40),
                            child: PinCodeTextField(
                              controller: roomController,
                              appContext: context, //
                              autoDisposeControllers: false,
                              animationType: AnimationType.fade,
                              pinTheme: PinTheme(
                                  shape: PinCodeFieldShape.underline,
                                  inactiveColor: Colors.grey),
                              animationDuration: Duration(milliseconds: 300),
                              length: 4,
                              onChanged: (value) {},
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 50,
                            child: TextField(
                              controller: nameController,
                              style: mystyle(20),
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText:
                                      "Name(Leave if you want your username)",
                                  labelStyle: TextStyle(fontSize: 12)),
                            ),
                          ),
                          CheckboxListTile(
                            activeColor: Colors.greenAccent,
                            value: isVideoMuted,
                            onChanged: (value) {
                              setState(() {
                                isVideoMuted = value;
                              });
                            },
                            title: Text("Video Muted"),
                          ),
                          CheckboxListTile(
                            activeColor: Colors.greenAccent,
                            value: isAudioMuted,
                            onChanged: (value) {
                              setState(() {
                                isAudioMuted = value;
                              });
                            },
                            title: Text("Audio Muted"),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Of course, you can customise your settings in the meeting ",
                            style: mystyle(12),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () => joinmeeting(),
                            child: Container(
                                width: MediaQuery.of(context).size.width / 2,
                                height: 30,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: LinearGradient(
                                        colors: GradientColors.green)),
                                child: Center(
                                  child: Text(
                                    "Join Meeting",
                                    style: mystyle(
                                      18,
                                      Colors.white,
                                    ),
                                  ),
                                )),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
