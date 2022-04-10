import 'package:ecommerce/Screens/ui/productDetailPage.dart';
import 'package:ecommerce/Screens/ui/shopingChartPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Comm/comHelper.dart';
import '../../DatabaseHandler/DbHelper.dart';
import '../../themes/light_color.dart';
import '../../themes/theme.dart';

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  bool isHomePageSelected = true;
  int PageSelected = 0;
  late var dbHelper;
  final oCcy =  NumberFormat.currency(
    locale: 'id',
    symbol: 'Rp '
  );
  bool _fav = false;

  List<Map<String, dynamic>> _products = [];

  void _refreshDB() async {
    final data = await dbHelper.getProduct();
    setState(() {
      _products = data;
    });
  }

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
    _refreshDB();
  }


  Widget _icon(IconData icon, {Color color = LightColor.iconColor}) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(13)),
          color: Colors.black12,
          boxShadow: AppTheme.shadow),
      child: Icon(
        icon,
        color: color,
      ),
    );
  }

  Widget _search() {
    return Container(
      margin: AppTheme.padding,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: LightColor.lightGrey.withAlpha(100),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: const TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search Products",
                    hintStyle: TextStyle(fontSize: 12),
                    contentPadding:
                    EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 5),
                    prefixIcon: Icon(Icons.search, color: Colors.black54)),
              ),
            ),
          ),
          SizedBox(width: 20),
          _icon(Icons.filter_list, color: Colors.black),
          SizedBox(width: 20),
          Bounceable(onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) =>  ShoppingCartPage()));

            alertDialog(context, "Shoping Chart");
          },
            child: Stack(
              children: <Widget>[
                _icon(Icons.shopping_basket, color: Colors.black),
              ],
            ),)
        ],
      ),
    );
  }

  Widget _categoryWidget() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: AppTheme.fullWidth(context),
      height: 40,
      child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Row(
        children: <Widget>[
          const SizedBox(width: 12.0),
          Container(
            padding: AppTheme.hPadding,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: LightColor.background,
              border: Border.all(
                color:  LightColor.orange,
                width: 2,
              ),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Color(0xfffbf2ef),
                  blurRadius: 10,
                  spreadRadius: 5,
                  offset: Offset(5, 5),
                ),
              ],
            ),
            child: Row(
              children: <Widget>[
                Image.asset("assets/images/shoe_thumb_2.png"),
                const SizedBox(width: 8.0),
                const Text(
                  "All",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12.0),
          Container(
            padding: AppTheme.hPadding,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: LightColor.background,
              border: Border.all(
                color:  LightColor.iconColor,
                width: 2,
              ),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Color(0xfffbf2ef),
                  blurRadius: 10,
                  spreadRadius: 5,
                  offset: Offset(5, 5),
                ),
              ],
            ),
            child: Row(
              children: <Widget>[
                Image.asset("assets/images/shoe_thumb_2.png"),
                const SizedBox(width: 8.0),
                const Text(
                  "Nike",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12.0),
          Container(
            padding: AppTheme.hPadding,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: LightColor.background,
              border: Border.all(
                color:  LightColor.iconColor,
                width: 2,
              ),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Color(0xfffbf2ef),
                  blurRadius: 10,
                  spreadRadius: 5,
                  offset: Offset(5, 5),
                ),
              ],
            ),
            child: Row(
              children: <Widget>[
                Image.asset("assets/images/shoe_thumb_2.png"),
                const SizedBox(width: 8.0),
                const Text(
                  "Converse",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12.0),
          Container(
            padding: AppTheme.hPadding,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: LightColor.background,
              border: Border.all(
                color:  LightColor.iconColor,
                width: 2,
              ),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Color(0xfffbf2ef),
                  blurRadius: 10,
                  spreadRadius: 5,
                  offset: Offset(5, 5),
                ),
              ],
            ),
            child: Row(
              children: <Widget>[
                Image.asset("assets/images/shoe_thumb_2.png"),
                const SizedBox(width: 8.0),
                const Text(
                  "Reebok",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12.0),
          Container(
            padding: AppTheme.hPadding,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: LightColor.background,
              border: Border.all(
                color:  LightColor.iconColor,
                width: 2,
              ),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Color(0xfffbf2ef),
                  blurRadius: 10,
                  spreadRadius: 5,
                  offset: Offset(5, 5),
                ),
              ],
            ),
            child: Row(
              children: <Widget>[
                Image.asset("assets/images/shoe_thumb_2.png"),
                const SizedBox(width: 8.0),
                const Text(
                  "Adidas",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12.0),
          Container(
            padding: AppTheme.hPadding,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: LightColor.background,
              border: Border.all(
                color:  LightColor.iconColor,
                width: 2,
              ),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Color(0xfffbf2ef),
                  blurRadius: 10,
                  spreadRadius: 5,
                  offset: Offset(5, 5),
                ),
              ],
            ),
            child: Row(
              children: <Widget>[
                Image.asset("assets/images/shoe_thumb_2.png"),
                const SizedBox(width: 8.0),
                const Text(
                  "Vans",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,),
                ),
              ],
            ),
          )
        ],
      )
    )
    );
  }

  Widget _productWidget() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: AppTheme.fullWidth(context),
      height: AppTheme.fullWidth(context) * 1.35,
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 3 / 4,
              crossAxisSpacing: 0,
              mainAxisSpacing: 0),
          itemCount: _products.length,
          physics: BouncingScrollPhysics(),
          itemBuilder: (BuildContext ctx, index) {
            if (index == _products.length) {
              return CupertinoActivityIndicator();
            }
            return Bounceable(
                onTap: () async {
                  print(_products[index]['product_id'].toString());
                  // ScaffoldMessenger.of(context)
                  //     .showSnackBar(SnackBar(
                  //         content: Text(
                  //             "${_listCoin[i]['id']} is tapped")));
                  await dbHelper.getProductId(_products[index]['product_id']);
                  Navigator.push(context,
                    MaterialPageRoute(builder: (_) => ProductDetail()));
                },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              child: Container(
                  decoration: const BoxDecoration(
                    color: LightColor.background,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(color: Color(0xfff8f8f8), blurRadius: 15, spreadRadius: 10),
                    ],
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Positioned(
                          left: 0,
                          top: 0,
                          child: IconButton(
                            icon: Icon(
                              Icons.favorite,
                              color: _fav == true
                                  ? Colors.redAccent
                                  : Colors.grey,
                            ),
                              onPressed: () async {}
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            SizedBox(height: 15),
                            Expanded(
                              child: Stack(
                                alignment: Alignment.center,
                                children: <Widget>[
                                  CircleAvatar(
                                    radius: 40,
                                    backgroundColor: LightColor.orange.withAlpha(40),
                                  ),
                                  Image.asset("assets/images/shooe_tilt_1.png")
                                ],
                              ),
                            ),
                            // SizedBox(height: 5),
                            Text(
                              "${_products[index]['product_name']}",
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 2),
                            Text(
                              "${_products[index]['brand_name']}",
                              style: const TextStyle(
                                fontSize: 14,
                                color: LightColor.orange,
                                fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "${oCcy.format(int.parse(_products[index]['price'])).toString()}",
                              style: TextStyle(fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
              ),
            ),
            );
          })
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      body: SafeArea(
        child: Container(
          // height: MediaQuery.of(context).size.height - 210,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // SizedBox(height: 50),
              _search(),
              _categoryWidget(),
              Expanded(
                child: Container(
                  // color: Color(0xfffeece2),
                  margin: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                  child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: <Widget>[
                          _productWidget(),
                        ],
                      )
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
