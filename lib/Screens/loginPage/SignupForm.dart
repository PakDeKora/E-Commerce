import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../Comm/comHelper.dart';
import '../../Comm/genLoginSignupHeader.dart';
import '../../Comm/genTextFormField.dart';
import '../../DatabaseHandler/DbHelper.dart';
import '../../Model/UserModel.dart';
import 'LoginForm.dart';
import '../../themes/light_color.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();

  final _conUserId = TextEditingController();
  final _conUserName = TextEditingController();
  final _conEmail = TextEditingController();
  final _conPassword = TextEditingController();
  final _conCPassword = TextEditingController();
  late var dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
  }

  signUp() async {
    String uid = _conUserId.text;
    String uname = _conUserName.text;
    String email = _conEmail.text;
    String passwd = _conPassword.text;
    String cpasswd = _conCPassword.text;

    if (_formKey.currentState!.validate()) {
      if (passwd != cpasswd) {
        alertDialog(context, 'Password Mismatch');
      } else {
        _formKey.currentState!.save();

        UserModel uModel = UserModel(uid, uname, email, passwd);
        await dbHelper.saveData(uModel).then((userData) {
          if (userData == 0){
            alertDialog(context, "User ID already registered");
          }
          else {
            alertDialog(context, "Successfully Saved");
            // Navigator.push(
                // context, MaterialPageRoute(builder: (_) => LoginForm()));
            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginForm()));
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => LoginForm()),
                    (Route<dynamic> route) => false);

          }
        }).catchError((error) {
          if (kDebugMode) {
            print(error);
          }
          alertDialog(context, "Error: Data Save Fail");
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Center(
              child: Container(
                height: MediaQuery.of(context).size.width * 1.8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    genLoginSignupHeader('Signup'),
                    getTextFormField(
                        controller: _conUserId,
                        icon: Icons.person,
                        hintName: 'User ID'),
                    const SizedBox(height: 10.0),
                    getTextFormField(
                        controller: _conUserName,
                        icon: Icons.person_outline,
                        inputType: TextInputType.name,
                        hintName: 'User Name'),
                    const SizedBox(height: 10.0),
                    getTextFormField(
                        controller: _conEmail,
                        icon: Icons.email,
                        inputType: TextInputType.emailAddress,
                        hintName: 'Email'),
                    const SizedBox(height: 10.0),
                    getTextFormField(
                      controller: _conPassword,
                      icon: Icons.lock,
                      hintName: 'Password',
                      isObscureText: true,
                    ),
                    const SizedBox(height: 10.0),
                    getTextFormField(
                      controller: _conCPassword,
                      icon: Icons.lock,
                      hintName: 'Confirm Password',
                      isObscureText: true,
                    ),
                    Container(
                      margin: const EdgeInsets.all(30.0),
                      width: double.infinity,
                      child: TextButton(
                        child: const Text(
                          'Signup',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: signUp,
                      ),
                      decoration: BoxDecoration(
                        color: LightColor.orange,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Does you have account? '),
                        TextButton(
                          // textColor: Colors.blue,
                          child: const Text(
                            'Sign In',
                            style: TextStyle(color: LightColor.orange),
                          ),
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (_) => LoginForm()),
                                    (Route<dynamic> route) => false);
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
      )
    );
  }
}
