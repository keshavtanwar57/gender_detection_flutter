import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'Model.dart';
import 'package:animated_text_kit/animated_text_kit.dart';




class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        height: double.infinity,
        width: double.infinity,
        color: Colors.black87,
        child: Column(
          children: [
            SizedBox(height: 30,),
          Center(
            child: SizedBox(
              width: double.infinity,
              child: TyperAnimatedTextKit(
                text: [
                  "GENDER",
                ],
                textStyle: TextStyle(
                    fontSize: 40.0,
                  fontFamily: 'Montserrat'
                ),
                textAlign: TextAlign.start,
              ),
            ),
          ),
            Center(
              child: SizedBox(
                width: double.infinity,
                child: TyperAnimatedTextKit(
                  text: [
                    "DETECTION",
                  ],
                  textStyle: TextStyle(
                      fontSize: 40.0,
                      fontFamily: 'Montserrat'
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            Lottie.asset('assets/2.json'),
            SizedBox(height: 100,),
            FlatButton(onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Model()),
              );
            },
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
              child: Container(
              height: 50,
              width: 100,
              child: Center(child: Text('>',
              style: TextStyle(fontSize: 25),)),
            ),color: Colors.green,)
          ],
        ),
      ),
    );
  }
}
