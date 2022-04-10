import 'package:ecommerce/Screens/loginPage/welcomeLogin.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../Comm/comHelper.dart';
import '../../Comm/genLoginSignupHeader.dart';
import '../../Comm/genTextFormField.dart';
import '../../DatabaseHandler/DbHelper.dart';
import '../../Model/UserModel.dart';
import 'SignupForm.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../themes/light_color.dart';
import '../mainPage.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  final _conUserId = TextEditingController();
  final _conPassword = TextEditingController();
  late var dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
  }

  login() async {
    String uid = _conUserId.text;
    String passwd = _conPassword.text;

    if (uid.isEmpty) {
      alertDialog(context, "Please Enter User ID");
    } else if (passwd.isEmpty) {
      alertDialog(context, "Please Enter Password");
    } else {
      await dbHelper.getLoginUser(uid, passwd).then((userData) {
        if (userData != null) {
          setSP(userData).whenComplete(() {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => welcomeDialog()),
                (Route<dynamic> route) => false);
          });
        } else {
          alertDialog(context, "Error: User Not Found");
        }
      }).catchError((error) {
        if (kDebugMode) {
          print(error);
        }
        alertDialog(context, "Error: Login Fail");
      });
    }
  }

  Future setSP(UserModel user) async {
    final SharedPreferences sp = await _pref;
    sp.setString("user_id", user.user_id!);
    sp.setString("user_name", user.user_name!);
    sp.setString("email", user.email!);
    sp.setString("password", user.password!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            height: MediaQuery.of(context).size.width * 1.8,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  genLoginSignupHeader('Login'),
                  getTextFormField(
                      controller: _conUserId,
                      icon: Icons.person,
                      hintName: 'User ID'),
                  const SizedBox(height: 10.0),
                  getTextFormField(
                    controller: _conPassword,
                    icon: Icons.lock,
                    hintName: 'Password',
                    isObscureText: true,
                  ),
                  Container(
                    margin: const EdgeInsets.all(30.0),
                    width: double.infinity,
                    child: TextButton(
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: login,
                    ),
                    decoration: BoxDecoration(
                      color: LightColor.orange,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Does not have account? '),
                      TextButton(
                        // textColor: Colors.blue,
                        child:
                        const Text(
                            'Signup',
                            style: TextStyle(color: LightColor.orange)
                        ),
                        onPressed: () {
                          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignupForm()));
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => SignupForm()));
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
