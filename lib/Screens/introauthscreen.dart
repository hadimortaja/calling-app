import 'package:calling_app/authentication/navigateAuthScreen.dart';
import 'package:calling_app/variables.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroAuthScreen extends StatefulWidget {
  @override
  _IntroAuthScreenState createState() => _IntroAuthScreenState();
}

class _IntroAuthScreenState extends State<IntroAuthScreen> {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
            title: "Welcome",
            body: "Mortaja's Meeting, the best video conference app",
            image: Center(
              child: Image.asset(
                'images/welcome.png',
                height: 175,
              ),
            ),
            decoration: PageDecoration(
                bodyTextStyle: mystyle(20, Colors.black),
                titleTextStyle: mystyle(
                  20,
                  Colors.black,
                ))),
        PageViewModel(
            title: "Join or start meetings",
            body:
                "Easy to use interface, join or start meetings in a fast time",
            image: Center(
              child: Image.asset(
                'images/conference.jpg',
                height: 175,
              ),
            ),
            decoration: PageDecoration(
                bodyTextStyle: mystyle(20, Colors.black),
                titleTextStyle: mystyle(20, Colors.black))),
        PageViewModel(
            title: "Security",
            body:
                "Your Security is important for us. Our servers are secure and reliable",
            image: Center(
              child: Image.asset(
                'images/secure.png',
                height: 175,
              ),
            ),
            decoration: PageDecoration(
                bodyTextStyle: mystyle(20, Colors.black),
                titleTextStyle: mystyle(20, Colors.black)))
      ],
      onDone: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => NavigateAuthScreen()));
      },
      onSkip: () {},
      showSkipButton: true,
      skip: Text(
        "Skip",
        style: TextStyle(fontSize: 18),
      ),
      next: const Icon(Icons.arrow_forward_ios),
      done: Text(
        "Done",
        style: mystyle(20, Colors.black),
      ),
    );
  }
}
