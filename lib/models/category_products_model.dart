import 'package:eshtri/models/single_product/single_product_model.dart';

class CategoryProductsModel {
  late final bool status;
  late CategoryProductsData? data;

  CategoryProductsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? CategoryProductsData.fromJson(json['data']) : null;
  }
  // to return a clone not just a reference copy
  CategoryProductsModel.copy(CategoryProductsModel model) {
    status = model.status;
    data = CategoryProductsData.copy(model.data!);
  }
}

class CategoryProductsData {
  late final List<SingleProductModel> products = [];

  CategoryProductsData.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((productMap) {
      products.add(SingleProductModel().fromJson(productMap));
    });
  }
  // to return a clone not just a reference copy
  CategoryProductsData.copy(CategoryProductsData model) {
    for (var product in model.products) {
      products.add(product.copy());
    }
  }
}
