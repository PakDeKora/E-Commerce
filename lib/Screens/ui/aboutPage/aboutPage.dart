import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'AccountForm.dart';

class aboutPage extends StatefulWidget {
  const aboutPage({Key? key}) : super(key: key);

  @override
  State<aboutPage> createState() => _aboutPageState();
}

class _aboutPageState extends State<aboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(15.0),
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              Image.asset("assets/images/dev.png",
                    height: 240,
                    width: 160),
                Text("I Made Rahadi Abhiyuda Anantajaya",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(height: 20,),
                Text("- Mobile Developer -",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),

            SizedBox(height: 25),
            Center(
              child: Card(
                elevation: 8.0,
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 10),
                      Text("Build, evaluate and maintain evaluate mobile app project using Flutter framework to support cross platform app development. Focus on how to deliver features for mobile user",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => AccountForm()));;
                  },
                  child: const Text("Account Setting",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.blue,
                      )),
                ),

              ],
            ),
            SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
