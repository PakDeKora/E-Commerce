import 'package:ecommerce/widgets/extentions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Comm/comHelper.dart';
import '../../DatabaseHandler/DbHelper.dart';
import '../../themes/light_color.dart';
import '../../themes/theme.dart';

class ProductDetail extends StatefulWidget {
  // const ProductDetail({Key? key}) : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail>
    with TickerProviderStateMixin {

  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  late AnimationController controller;
  late Animation<double> animation;
  late var dbHelper;
  final oCcy =  NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp '
  );
  String text_userID = "";
  String text_prodID = "";
  String text_prodBrand = "";
  String text_prodName = "";
  String text_prodPrice = "";
  String text_prodImage = "";

  int isLove = 0;

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    animation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInToLinear));
    controller.forward();

    getUserData();

  }

  Future<void> getUserData() async {
    final SharedPreferences sp = await _pref;
    setState(() {
      text_userID = sp.getString("user_id")!;
      text_prodID = sp.getString("prod_id")!;
      text_prodBrand = sp.getString("prod_brand_name")!;
      text_prodName = sp.getString("prod_name")!;
      text_prodPrice = sp.getString("prod_price")!;
      text_prodImage = sp.getString("prod_image")!;

      dbHelper.getFavoriteId(sp.getString("user_id")!, sp.getString("prod_id")!).then((result){
        setState(() {
          isLove = result;
          if (kDebugMode) {
            print("Result Favorite $isLove");
          }
          return result;
        });
      });

    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool isLiked = false;
  Widget _appBar() {
    return Container(
      padding: AppTheme.padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _icon(
            Icons.arrow_back_ios,
            color: Colors.black54,
            size: 15,
            padding: 12,
            isOutLine: true,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          _icon(isLove != 0 ? Icons.favorite : Icons.favorite_border, // 1 , 0
              color: isLove != 0 ? LightColor.red : LightColor.black, // 1 , 0
              size: 15,
              padding: 12,
              isOutLine: false, onPressed: () {
                setState(() {
                  if (isLove != 0) {
                    isLove = 0;
                    dbHelper.unFav(text_userID, text_prodID).then((result){
                      setState(() {
                        var res  = result;
                        print("proses del $res");
                        alertDialog(context, "Remove Favorited");
                      });
                    });
                  }
                  else {
                    isLove = 1;
                    dbHelper.addFav(text_userID, text_prodID).then((result){
                      setState(() {
                        var res  = result;
                        print("proses add $res");
                        alertDialog(context, "Favorited");
                      });
                    });
                  }
                });
              }),
        ],
      ),
    );
  }

  Widget _icon(
      IconData icon, {
        Color color = LightColor.iconColor,
        double size = 20,
        double padding = 10,
        bool isOutLine = false,
        required Function onPressed,
      }) {
    return Container(
      height: 40,
      width: 40,
      padding: EdgeInsets.all(padding),
      // margin: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        border: Border.all(
            color: LightColor.iconColor,
            style: isOutLine ? BorderStyle.solid : BorderStyle.none),
        borderRadius: BorderRadius.all(Radius.circular(13)),
        color:
        isOutLine ? Colors.transparent : Colors.white,
        boxShadow: const <BoxShadow>[
          BoxShadow(
              color: Color(0xfff8f8f8),
              blurRadius: 5,
              spreadRadius: 10,
              offset: Offset(5, 5)),
        ],
      ),
      child: Icon(icon, color: color, size: size),
    ).ripple(() {
      if (onPressed != null) {
        onPressed();
      }
    }, borderRadius: BorderRadius.all(Radius.circular(13)));
  }

  Widget _productImage() {
    return AnimatedBuilder(
      builder: (context, child) {
        return AnimatedOpacity(
          duration: Duration(milliseconds: 500),
          opacity: animation.value,
          child: child,
        );
      },
      animation: animation,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              text_prodBrand.toUpperCase(),
              style: const TextStyle(
                fontSize: 160,
                color: LightColor.lightGrey,
              ),
            ),
          ),
          Image.asset('assets/images/show_1.png')
        ],
      ),
    );
  }

  Widget _detailWidget() {
    return Container(
      padding: AppTheme.padding.copyWith(bottom: 0),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
          color: Colors.white
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          SizedBox(height: 5),
          Container(
            alignment: Alignment.center,
            child: Container(
              width: 50,
              height: 5,
              decoration: const BoxDecoration(
                  color: LightColor.iconColor,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
          ),
          SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                  text_prodName,
                  style: TextStyle(fontSize: 25)),
              const SizedBox(
                height: 10,
              ),
              Text(
                oCcy.format(int.parse(text_prodPrice)).toString(),
                style: const TextStyle(
                  fontSize: 25,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          _description(),
        ],
      ),
    );
  }

  Widget _description() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        Text(
          "Description",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: 20),
        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
      ],
    );
  }

  FloatingActionButton _flotingButton() {
    return FloatingActionButton(
      onPressed: () {},
      backgroundColor: LightColor.orange,
      child: Icon(Icons.shopping_basket,
          color: Theme.of(context).floatingActionButtonTheme.backgroundColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _flotingButton(),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xfffbfbfb),
                  Color(0xfff7f7f7),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )),
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  _appBar(),
                  _productImage(),
                  _detailWidget(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
