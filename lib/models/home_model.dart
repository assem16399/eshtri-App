import 'single_product/single_product_model.dart';

class HomeModel {
  late final bool status;
  late final HomeData? data;

  HomeModel(this.status, this.data);

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? HomeData.fromJson(json['data']) : null;
  }
}

class HomeData {
  final List<BannerModel> banners = [];
  final List<SingleProductModel> products = [];
  HomeData.fromJson(Map<String, dynamic> json) {
    json['banners'].forEach((banner) {
      banners.add(BannerModel.fromJson(banner));
    });
    json['products'].forEach((product) {
      products.add(SingleProductModel().fromJson(product));
    });
  }
}

class BannerModel {
  late final dynamic id;
  late final dynamic imageUrl;
  late final dynamic category;
  late final dynamic product;

  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageUrl = json['image'];
    category = json['category'];
    product = json['product'];
  }
}
