
class ChartModel {
  int? id;
  String? user_id;
  String? product_id;
  int? chart_ety;

  ChartModel(this.user_id, this.product_id, this.chart_ety);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'user_id': user_id,
      'product_id': product_id,
      'chart_ety': chart_ety
    };
    return map;
  }

  ChartModel.fromMap(Map<String, dynamic> map) {
    user_id = map['user_id'];
    product_id = map['product_id'];
    chart_ety = map['chart_ety'];
  }
}
