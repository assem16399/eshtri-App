class HomeModel {
  late final bool status;
  late final HomeData? data;
  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? HomeData.fromJson(json['data']) : null;
  }
}

class HomeData {
  final List<BannerModel> banners = [];
  final List<ProductModel> products = [];
  HomeData.fromJson(Map<String, dynamic> json) {
    json['banners'].map((banner) {
      banners.add(BannerModel(banner));
    }).toList();
    json['products'].map((product) {
      products.add(ProductModel.fromJson(product));
    }).toList();
  }
}

class BannerModel {
  late final dynamic id;
  late final dynamic imageUrl;
  late final dynamic category;
  late final dynamic product;

  BannerModel(Map<String, dynamic> json) {
    id = json['id'];
    imageUrl = json['image'];
    category = json['category'];
    product = json['product'];
  }
}

class ProductModel {
  late final dynamic id;
  late final dynamic name;
  late final dynamic imageUrl;
  late final dynamic price;
  late final dynamic oldPrice;
  late final dynamic discount;
  late final dynamic inFavorites;
  late final dynamic inCart;

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageUrl = json['image'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
