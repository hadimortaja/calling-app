import 'package:calling_app/variables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String username = '';
  String email = '';
  bool dataisthere = false;
  TextEditingController usernameController = TextEditingController();
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
      email = userdoc.data()['email'];
      dataisthere = true;
    });
  }

  editProfile() async {
    userCollection
        .doc(FirebaseAuth.instance.currentUser.uid)
        .update({'username': usernameController.text});
    setState(() {
      username = usernameController.text;
    });
    Navigator.pop(context);
  }

  openEditProfileDialog() async {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              height: 150,
              child: Column(
                children: [
                  
                  Container(
                    margin: EdgeInsets.only(left: 40, right: 40),
                    child: TextField(
                      controller: usernameController,
                      // style: ,
                      decoration: InputDecoration(
                          labelText: "Update username",
                          labelStyle:
                              TextStyle(fontSize: 16, color: Colors.grey)),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    onTap: () {
                      editProfile();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.greenAccent
                         ),
                      child: Center(
                        child: Text(
                          "Update now!",
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.black, fontSize: 25),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 2.0,
      ),

      body: dataisthere == false
          ? Center(
                child: CupertinoActivityIndicator()): Container(
              margin: EdgeInsets.only(bottom: 60),
              // height: 400,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 55,
                    backgroundImage: NetworkImage(
                      'https://previews.123rf.com/images/salamatik/salamatik1801/salamatik180100019/92979836-profile-anonymous-face-icon-gray-silhouette-person-male-default-avatar-photo-placeholder-isolated-on.jpg'
                    ),
                    backgroundColor: Colors.grey[700],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    username,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    email,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: 180,
                    child: RaisedButton(
                      color: Colors.greenAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      onPressed: () {
                        openEditProfileDialog();
                      },
                      child: Center(
                          child: Text("Edit Your Name",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16))),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 40,
                    width: 300,
                    child: RaisedButton(
                        onPressed: () {},
                        color: Colors.grey[200],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.person_outline_rounded,
                              color: Colors.grey[700],
                              size: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Privacy",
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                            SizedBox(
                              width: 170,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey[700],
                              size: 15,
                            )
                          ],
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 40,
                    width: 300,
                    child: RaisedButton(
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                        },
                        color: Colors.grey[200],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.logout,
                              color: Colors.grey[700],
                              size: 18,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Log Out",
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                            SizedBox(
                              width: 172,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey[700],
                              size: 15,
                            )
                          ],
                        )),
                  ),
                ],
              ),
            ),
    );
  }
}
