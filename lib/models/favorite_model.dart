class FavoriteModel {
  late bool status;
  late FavoriteDataModel data;

  FavoriteModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = FavoriteDataModel.fromJson(json['data']);
  }
}

class FavoriteDataModel {
  late int currentPage;
  late List<DataModel> data = [];

  FavoriteDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((value) {
      data.add(DataModel.fromJson(value));
    });
  }
}

class DataModel {
  late int id;
  late ProductModel product;

  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = ProductModel.fromJson(json['product']);
  }
}

class ProductModel {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String image;
  late String name;

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
  }
}
