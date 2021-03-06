
class FavoriteModel {
  int? id;
  String? user_id;
  String? product_id;

  FavoriteModel(this.user_id, this.product_id);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'user_id': user_id,
      'product_id': product_id
    };
    return map;
  }

  FavoriteModel.fromMap(Map<String, dynamic> map) {
    user_id = map['user_id'];
    product_id = map['product_id'];
  }
}
