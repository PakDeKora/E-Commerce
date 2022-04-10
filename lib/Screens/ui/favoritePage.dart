import 'package:flutter/material.dart';
import '../../themes/light_color.dart';
import '../../themes/theme.dart';

class FavoritePage extends StatefulWidget {

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {

  bool isHomePageSelected = true;
  int PageSelected = 0;

  Widget _item() {
    return Container(
      height: 80,
      child: Row(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1.2,
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    height: 70,
                    width: 70,
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            decoration: BoxDecoration(
                                color: LightColor.lightGrey,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: -20,
                  bottom: -20,
                  child: Image.asset("assets/images/small_tilt_shoe_1.png"),
                )
              ],
            ),
          ),
          Expanded(
              child: ListTile(
                  title: const Text(
                    "Nike Air Max 200",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),

                  ),
                  subtitle: Row(
                    children: const <Widget>[
                      Text(
                          "\$ ",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          )
                      ),
                      Text(
                          "240.00",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          )
                      )
                    ],
                  ),
                  trailing: Container(
                    width: 35,
                    height: 35,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        // color: LightColor.lightGrey.withAlpha(150),
                        borderRadius: BorderRadius.circular(10)),
                    child: IconButton(
                        icon: Icon(Icons.favorite,
                        color: LightColor.red,
                      ),
                      onPressed: () {},
                    ),
                  )))
        ],
      ),
    );
  }

  Widget _price() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const <Widget>[
        Text(
          '2 Items',
          style: TextStyle(
            color: LightColor.grey,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          '\$ 480.00',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ],
    );
  }

  Widget _submitButton(BuildContext context) {
    return TextButton(
      onPressed: () {},
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(LightColor.orange),
      ),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 4),
        width: AppTheme.fullWidth(context) * .75,
        child: Text(
          'Next',
          style: TextStyle(
            color: LightColor.background,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: AppTheme.padding,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _item(),
                Divider(
                  thickness: 1,
                  height: 70,
                ),
                _price(),
                SizedBox(height: 30),
                // _submitButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

