import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../DatabaseHandler/DbHelper.dart';
import 'ui/HomePage.dart';
import 'loginPage/LoginForm.dart';
import 'mainPage.dart';

class SplashPage extends StatefulWidget{
  const SplashPage({Key? key}) : super(key: key);

  @override
  State createState() {
    return SplashState();
  }
}
class SplashState extends State
{
  late DbHelper dbHelper;
  late int loginData;

  @override
  void initState() {
    super.initState();
    loginData = 0;
    dbHelper = DbHelper();

    Future.delayed(const Duration(seconds: 1), () {
      dbHelper.getUserLogin().then((result){
        setState(() {
          loginData = result;
          if(loginData == 0) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (BuildContext context) => LoginForm())
            );
            // Navigator.pushAndRemoveUntil(
            //     context,
            //     MaterialPageRoute(builder: (_) => LoginForm()),
            //         (Route<dynamic> route) => false);
          } else{
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (BuildContext context) => MainPage())
            );
            // Navigator.pushAndRemoveUntil(
            //     context,
            //     MaterialPageRoute(builder: (_) => HomeForm()),
            //         (Route<dynamic> route) => false);
          }
            if (kDebugMode) {
              print("Called Return value on state  $loginData");
            }
        });
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Image.asset("assets/images/monica.png"),
        ),
      )
    );
  }
}