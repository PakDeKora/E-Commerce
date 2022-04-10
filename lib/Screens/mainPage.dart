import 'dart:collection';
import 'package:flutter/material.dart';
import 'ui/aboutPage/AccountForm.dart';
import 'ui/HomePage.dart';
import 'ui/aboutPage/aboutPage.dart';
import 'ui/favoritePage.dart';

class MainPage extends StatefulWidget {
  // const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  ListQueue<int> _navigationQueue =ListQueue();
  int index=0;

  Widget getBody(int index) {
    switch (index) {
      case 0:
        return MyHomePage(); // Create this function, it should return your first page as a widget
      case 1:
        return FavoritePage();// Create this function, it should return your second page as a widget
      case 2:
        return aboutPage(); // Create this function, it should return your third page as a widget
    }
    return MyHomePage();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        /* Use this code if you just want to go back to 0th index*/
        if(index == 0)
          return true;
        setState(() {
          index = 0;
        });
        return false;
        /* below code keeps track of all the navigated indexes*/
        // if(_navigationQueue.isEmpty)
        //   return true;
        //
        // setState(() {
        //   index = _navigationQueue.last;
        //   _navigationQueue.removeLast();
        // });
        // return false;
      },
      child: Scaffold(
        body: (getBody(index)),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: Color(0xFFf5851f),
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          currentIndex: index,
          // handles onTap on bottom navigation bar item
          onTap: (value) {
            _navigationQueue.addLast(index);
            setState(() => index = value);
            print(value);
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border),
                label: 'Favorite'),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_outlined),
                label: 'Account'),
          ],
        ),

      ),
    );


  }
}
