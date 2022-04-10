import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../Comm/comHelper.dart';
import '../../../Comm/genTextFormField.dart';
import '../../../DatabaseHandler/DbHelper.dart';
import '../../../Model/UserModel.dart';
import '../../loginPage/LoginForm.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../mainPage.dart';

class AccountForm extends StatefulWidget {
  // const AccountForm({Key? key}) : super(key: key);

  @override
  _AccountFormState createState() => _AccountFormState();
}

class _AccountFormState extends State<AccountForm> {
  final _formKey = GlobalKey<FormState>();
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  late DbHelper dbHelper;
  final _conUserId = TextEditingController();
  final _conDelUserId = TextEditingController();
  final _conUserName = TextEditingController();
  final _conEmail = TextEditingController();
  final _conPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUserData();

    if (_conUserId == null){
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => LoginForm()),
              (Route<dynamic> route) => false);
    }

    dbHelper = DbHelper();
  }

  Future<void> getUserData() async {
    final SharedPreferences sp = await _pref;
    setState(() {
      _conUserId.text = sp.getString("user_id")!;
      _conDelUserId.text = sp.getString("user_id")!;
      _conUserName.text = sp.getString("user_name")!;
      _conEmail.text = sp.getString("email")!;
      _conPassword.text = sp.getString("password")!;
    });
  }

  update() async {
    String uid = _conUserId.text;
    String uname = _conUserName.text;
    String email = _conEmail.text;
    String passwd = _conPassword.text;

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      UserModel user = UserModel(uid, uname, email, passwd);
      await dbHelper.updateUser(user).then((value) {
        if (value == 1) {
          alertDialog(context, "Successfully Updated");

          updateSP(user, true).whenComplete(() {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => MainPage()),
                (Route<dynamic> route) => false);
          });
        } else {
          alertDialog(context, "Error Update");
        }
      }).catchError((error) {
        if (kDebugMode) {
          print(error);
        }
        alertDialog(context, "Error");
      });
    }
  }

  delete() async {
    String delUserID = _conDelUserId.text;

    await dbHelper.deleteUser(delUserID).then((value) async {
      if (value == 1) {
        alertDialog(context, "Successfully Deleted");

        await dbHelper.logoutUser(delUserID).then((value) {
          if (value == 1) {
            alertDialog(context, "Successfully Logout");

            updateSP(null, false).whenComplete(() {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => LoginForm()),
                      (Route<dynamic> route) => false);
            });
          }
        });
        // updateSP(null, false).whenComplete(() {
        //   Navigator.pushAndRemoveUntil(
        //       context,
        //       MaterialPageRoute(builder: (_) => LoginForm()),
        //       (Route<dynamic> route) => false);
        // });
      }
    });
  }

  logout() async {
    String delUserID = _conDelUserId.text;
    await dbHelper.logoutUser(delUserID).then((value) {
      if (value == 1) {
        alertDialog(context, "Successfully Logout");

        updateSP(null, false).whenComplete(() {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => LoginForm()),
                  (Route<dynamic> route) => false);
        });
      }
    });
  }

  Future updateSP(UserModel? user, bool add) async {
    final SharedPreferences sp = await _pref;

    if (add) {
      sp.setString("user_name", user!.user_name!);
      sp.setString("email", user.email!);
      sp.setString("password", user.password!);
    } else {
      sp.remove('user_id');
      sp.remove('user_name');
      sp.remove('email');
      sp.remove('password');
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
            child: Container(
              margin: const EdgeInsets.only(top: 20.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Update
                    getTextFormField(
                        controller: _conUserId,
                        isEnable: false,
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
                    Container(
                      margin: const EdgeInsets.all(30.0),
                      width: double.infinity,
                      child: TextButton(
                        child: const Text(
                          'Update',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: update,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    getTextFormField(
                        controller: _conDelUserId,
                        isEnable: false,
                        icon: Icons.person,
                        hintName: 'User ID'),
                    Container(
                      margin: const EdgeInsets.all(30.0),
                      width: double.infinity,
                      child: TextButton(
                        child: const Text(
                          'Delete',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: delete,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(30.0),
                      width: double.infinity,
                      child: TextButton(
                        child: const Text(
                          'Logout',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: logout,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
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
