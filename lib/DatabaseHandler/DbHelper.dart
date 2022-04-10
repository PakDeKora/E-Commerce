import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../Model/ProductModel.dart';
import '../Model/UserModel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

class DbHelper {
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  static Database? _db;

  static const String db_name = 'ecommerce.db';

  static const String table_user = 'user';
  static const String table_login = 'login';
  static const String C_UserID = 'user_id';
  static const String C_UserName = 'user_name';
  static const String C_Email = 'email';
  static const String C_Password = 'password';

  static const String table_product = 'product';
  static const String C_ProductId = 'product_id';
  static const String C_BrandName = 'brand_name';
  static const String C_ProductName = 'product_name';
  static const String C_Price = 'price';
  static const String C_Image = 'image';

  static const String table_favorite = 'favorite';
  static const String table_chart = 'chart';
  static const String C_Id = 'id';
  static const String C_IDUser = 'user_id';
  static const String C_IDProduct = 'product_id';
  static const String C_chartETY = 'chart_ety';


  static const int Version = 1;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, db_name);
    var db = await openDatabase(path, version: Version, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int intVersion) async {
    await db.execute("CREATE TABLE $table_user ("
        " $C_UserID TEXT PRIMARY KEY, "
        " $C_UserName TEXT, "
        " $C_Email TEXT,"
        " $C_Password TEXT "
        ")");
    await db.execute("CREATE TABLE $table_login ("
        " $C_UserID TEXT PRIMARY KEY, "
        " $C_UserName TEXT, "
        " $C_Email TEXT,"
        " $C_Password TEXT "
        ")");
    await db.execute("CREATE TABLE $table_chart ("
        " $C_Id INTEGER PRIMARY KEY AUTOINCREMENT, "
        " $C_IDUser TEXT, "
        " $C_IDProduct TEXT "
        " $C_chartETY INTEGER "
        ")");
    await db.execute("CREATE TABLE $table_favorite ("
        " $C_Id INTEGER PRIMARY KEY AUTOINCREMENT, "
        " $C_IDUser TEXT, "
        " $C_IDProduct TEXT "
        ")");
    await db.execute("CREATE TABLE $table_product ("
        " $C_ProductId INTEGER PRIMARY KEY AUTOINCREMENT, "
        " $C_BrandName TEXT, "
        " $C_ProductName TEXT,"
        " $C_Price TEXT, "
        " $C_Image TEXT "
        ")");
    List<Map> data = [
      {C_ProductId: 1, C_BrandName: 'Nike', C_ProductName: 'Air Zoom SuperRep 2', C_Price: '1799000', C_Image: 'nike1'},
      {C_ProductId: 2, C_BrandName: 'Nike', C_ProductName: 'AF 1/11', C_Price: 209900, C_Image: 'nike2'},
      {C_ProductId: 3, C_BrandName: 'Nike', C_ProductName: 'SuperRep Go', C_Price: 1429000, C_Image: 'nike3'},
      {C_ProductId: 4, C_BrandName: 'Nike', C_ProductName: 'Balzer Mid77 Vintage', C_Price: 1799000, C_Image: 'nike4'},
      {C_ProductId: 5, C_BrandName: 'Adidas', C_ProductName: 'Neo City/Racer', C_Price: 820000, C_Image: 'adidas1'},
      {C_ProductId: 6, C_BrandName: 'Adidas', C_ProductName: 'Adipure 360.2 M M18107', C_Price: 59500, C_Image: 'adidas2'},
      {C_ProductId: 7, C_BrandName: 'Adidas', C_ProductName: 'CC Fresh 2 M-B40448', C_Price: 710000, C_Image: 'adidas3'},
      {C_ProductId: 8, C_BrandName: 'Adidas', C_ProductName: 'Essential Star 2 AF5506', C_Price: 740000, C_Image: 'adidas4'},
      {C_ProductId: 9, C_BrandName: 'Vans', C_ProductName: 'Old Skool Vintage Suede', C_Price: 1055500, C_Image: 'vans1'},
      {C_ProductId: 10, C_BrandName: 'Vans', C_ProductName: 'Sk8 Hi X Eley Kishimoto', C_Price: 1100500, C_Image: 'vans2'},
      {C_ProductId: 11, C_BrandName: 'Vans', C_ProductName: 'Old Skool Checkerboard', C_Price: 300500, C_Image: 'vans3'},
      {C_ProductId: 12, C_BrandName: 'Vans', C_ProductName: 'Era Star Wars Waffle Hf', C_Price: 550500, C_Image: 'vans4'},
      {C_ProductId: 13, C_BrandName: 'Converse', C_ProductName: 'Jack Purcell', C_Price: 859000, C_Image: 'converse1'},
      {C_ProductId: 14, C_BrandName: 'Converse', C_ProductName: 'One Star CC Slip', C_Price: 699000, C_Image: 'converse2'},
      {C_ProductId: 15, C_BrandName: 'Converse', C_ProductName: 'Louie Lopez Pro', C_Price: 999000, C_Image: 'converse3'},
      {C_ProductId: 16, C_BrandName: 'Converse', C_ProductName: 'Courtlandt', C_Price: 659000, C_Image: 'converse4'},
      {C_ProductId: 17, C_BrandName: 'Reebok', C_ProductName: 'GS Ventilator', C_Price: 649000, C_Image: 'reebok1'},
      {C_ProductId: 18, C_BrandName: 'Reebok', C_ProductName: 'Sport Fury LP', C_Price: 615500, C_Image: 'reebok2'},
      {C_ProductId: 19, C_BrandName: 'Reebok', C_ProductName: 'Royal Sprint', C_Price: 677500, C_Image: 'reebok3'},
      {C_ProductId: 20, C_BrandName: 'Reebok', C_ProductName: 'Sublite Escape', C_Price: 505000, C_Image: 'reebok4'}
    ];
    data.forEach((element) async {
      await db.rawInsert("INSERT INTO $table_product ("
              " $C_ProductId, "
              " $C_BrandName, "
              " $C_ProductName,"
              " $C_Price, "
              " $C_Image "
              ") VALUES (?, ?, ?, ?, ?)", [element[C_ProductId], element[C_BrandName], element[C_ProductName], element[C_Price], element[C_Image]]
      );
    });
  }

  Future<int> saveData(UserModel user) async {
    var dbClient = await (db as FutureOr<Database>);
    var val = await dbClient.rawQuery(
        "SELECT * FROM $table_user WHERE $C_UserID = ?", [user.user_id]);

    if (val.isEmpty) {
      var res = await dbClient.insert(table_user, user.toMap());
      return res;
    } else {
      return 0;
    }
    // return null;
  }

  Future<UserModel?> getLoginUser(String userId, String password) async {
    var dbClient = await (db as FutureOr<Database>);
    var res = await dbClient.rawQuery("SELECT * FROM $table_user WHERE "
        "$C_UserID = '$userId' AND "
        "$C_Password = '$password'");

    if (res.isNotEmpty) {
      await dbClient
          .rawQuery("INSERT INTO $table_login SELECT * FROM $table_user WHERE "
              "$C_UserID = '$userId' AND "
              "$C_Password = '$password'");

      var session = await dbClient.rawQuery("SELECT * FROM $table_user WHERE "
          "$C_UserID = '$userId' AND "
          "$C_Password = '$password'");

      return UserModel.fromMap(session.first);
    }
    return null;
  }

  Future<int> updateUser(UserModel user) async {
    var dbClient = await (db as FutureOr<Database>);
    var res = await dbClient.update(table_user, user.toMap(),
        where: '$C_UserID = ?', whereArgs: [user.user_id]);
    return res;
  }

  Future<int> deleteUser(String user_id) async {
    var dbClient = await (db as FutureOr<Database>);
    var res = await dbClient.delete(table_user,
        where: '$C_UserID = ?', whereArgs: [user_id]);
    return res;
  }

  Future<int> logoutUser(String user_id) async {
    var dbClient = await (db as FutureOr<Database>);
    var res = await dbClient
        .delete(table_login, where: '$C_UserID = ?', whereArgs: [user_id]);
    return res;
  }

  Future<int> getUserLogin() async {
    var dbClient = await (db as FutureOr<Database>);
    var logins = await dbClient.rawQuery("SELECT * FROM $table_login");
    if (logins.isEmpty) return 0;
    return logins.length;
  }

  Future<List<Map<String, dynamic>>> getProduct() async {
    var dbClient = await (db as FutureOr<Database>);
    return dbClient.rawQuery("SELECT * FROM $table_product");
  }

  Future<ProductModel?> getProductId(int prodId) async {
    var dbClient = await (db as FutureOr<Database>);
    var res = await dbClient.rawQuery("SELECT * FROM $table_product WHERE "
        "$C_ProductId = $prodId ");

    var prodResult = ProductModel.fromMap(res.first);
    setSP(prodResult);

    return prodResult;
  }

  Future setSP(ProductModel prod) async {
    final SharedPreferences sp = await _pref;
    sp.setString("prod_id", prod.product_id.toString());
    sp.setString("prod_brand_name", prod.brand_name!);
    sp.setString("prod_name", prod.product_name!);
    sp.setString("prod_price", prod.price!);
    sp.setString("prod_image", prod.image!);
  }

  Future<int> getFavoriteId(String userId, String prodId) async {
    var dbClient = await (db as FutureOr<Database>);
    var favResult = await dbClient
        .rawQuery("SELECT * FROM $table_favorite WHERE "
        "$C_IDUser = ? AND $C_IDProduct = ? ", [userId, prodId]);
    if (favResult.isEmpty) return 0;
    return favResult.length;
  }

  Future<List<Map<String, Object?>>> addFav(String _uId, String _pId) async {
    var dbClient = await (db as FutureOr<Database>);
    var newFav = await dbClient
        .rawQuery("INSERT INTO $table_favorite ("
        "$C_IDUser, "
        "$C_IDProduct"
        ") VALUES ( ?, ? ) ", [_uId, _pId]);
    return newFav;
  }

  Future<List<Map<String, Object?>>> unFav(String _uId, String _pId) async {
    var dbClient = await (db as FutureOr<Database>);
    var delFav = await dbClient
        .rawQuery("DELETE FROM $table_favorite WHERE "
        "$C_IDUser = ? AND $C_IDProduct = ? ", [_uId, _pId]);
    return delFav;
  }

  Future<List<Map<String, Object?>>> addChart(String _uId, String _pId, int _cEty) async {
    var dbClient = await (db as FutureOr<Database>);
    var validateChart = await dbClient
        .rawQuery("SELECT * FROM $table_chart WHERE "
        "$C_IDUser = ? AND $C_IDProduct = ? ", [_uId, _pId]);
    if (validateChart.isEmpty ) {
      var addChart = await dbClient
          .rawQuery("INSERT INTO $table_chart ("
          "$C_IDUser, "
          "$C_IDProduct, "
          "$C_chartETY, "
          ") VALUES ( ?, ?, ? ) ", [_uId, _pId, _cEty]);
      return addChart;
    }
    else {
      var updateChart = await dbClient
          .rawQuery("UPDATE $table_chart "
          "SET $C_chartETY = ? "
          "WHERE $C_IDUser = ? AND $C_IDProduct = ? ", [_cEty, _uId, _pId]);
      return updateChart;
    }
  }

  Future<List<Map<String, Object?>>> delChartEty(String _uId, String _pId, int _cEty) async {
    var dbClient = await (db as FutureOr<Database>);
    var validateChart = await dbClient
        .rawQuery("SELECT * FROM $table_chart WHERE "
        "$C_IDUser = ? AND $C_IDProduct = ? AND $C_chartETY != 0", [_uId, _pId]);
    if (validateChart.isNotEmpty ) {
      var updateChart = await dbClient
          .rawQuery("UPDATE $table_chart "
          "SET $C_chartETY = ? "
          "WHERE $C_IDUser = ? AND $C_IDProduct = ? ", [_cEty, _uId, _pId]);
      return updateChart;
    }
    else {
      var delChart = await dbClient
          .rawQuery("DELETE FROM $table_chart WHERE "
          "$C_IDUser = ? AND $C_IDProduct = ? ", [_uId, _pId]);
      return delChart;
    }
  }
}
