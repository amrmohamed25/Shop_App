class SearchModel {
  late bool status;
  late SearchDataModel data;

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = SearchDataModel.fromJson(json['data']);
  }
}

class SearchDataModel {
  late int currentPage;
  late List<ProductSearchModel> data = [];

  SearchDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((value) {
      data.add(ProductSearchModel.fromJson(value));
    });
  }
}

class ProductSearchModel {
  late int id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  late String image;
  late String name;

  ProductSearchModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
  }
}
