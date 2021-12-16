import 'package:eshtri/models/single_product/single_product_model.dart';

class FavoritesModel {
  late final bool status;
  late final FavoritesModelData? data;

  FavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? FavoritesModelData.fromJson(json['data']) : null;
  }
}

class FavoritesModelData {
  late final List<FavoritesData> data = [];

  FavoritesModelData.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((element) {
      data.add(FavoritesData.fromJson(element));
    });
  }
}

class FavoritesData {
  late final int productIdInFavorites;
  late final SingleProductModel singleProductModel;

  FavoritesData.fromJson(Map<String, dynamic> json) {
    productIdInFavorites = json['id'];
    singleProductModel = SingleProductModel().fromJson(json['product']);
  }
}
