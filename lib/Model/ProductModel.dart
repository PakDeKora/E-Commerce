
class ProductModel {
  int? product_id;
  String? brand_name;
  String? product_name;
  String? price;
  String? image;

  ProductModel(this.product_id, this.brand_name, this.product_name, this.price, this.image);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'product_id': product_id,
      'brand_name': brand_name,
      'product_name': product_name,
      'price': price,
      'image': image
    };
    return map;
  }

  ProductModel.fromMap(Map<String, dynamic> map) {
    product_id = map['product_id'];
    brand_name = map['brand_name'];
    product_name = map['product_name'];
    price = map['price'];
    image = map['image'];
  }
}
