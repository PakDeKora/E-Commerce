import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../DatabaseHandler/DbHelper.dart';
import '../mainPage.dart';

class welcomeDialog extends StatefulWidget {
  const welcomeDialog({Key? key}) : super(key: key);

  @override
  State<welcomeDialog> createState() => _welcomeDialogState();
}

class _welcomeDialogState extends State<welcomeDialog> {
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  TextStyle textStyle = const TextStyle (color: Colors.black);
  late DbHelper dbHelper;

  String uid = "";

  @override
  void initState() {
    super.initState();
    getUserData();
    dbHelper = DbHelper();
  }

  Future<void> getUserData() async {
    final SharedPreferences sp = await _pref;
    setState(() {
      uid = sp.getString("user_id")!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
          child:  AlertDialog(
            title: Text("E-Commerce",style: textStyle,),
            content: Text("Welcome ${uid}", style: textStyle,),
            actions: <Widget>[
              TextButton(
                child: Text("Continue"),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => MainPage()),
                          (Route<dynamic> route) => false);
                },
              ),
            ],
          )),
    );
  }
}
