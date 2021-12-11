class HomeModel {
  late final bool status;
  late final HomeData? data;
  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? HomeData.fromJson(json['data']) : null;
  }
  Map<String, dynamic> toJson({HomeModel? model}) {
    if (model != null) {
      return {'status': model.status, 'data': model.data!.toJson(model: model.data!)};
    } else {
      return {'status': status, 'data': data!.toJson()};
    }
  }
}

class HomeData {
  final List<BannerModel> banners = [];
  final List<ProductModel> products = [];
  HomeData.fromJson(Map<String, dynamic> json) {
    json['banners'].map((banner) {
      banners.add(BannerModel.fromJson(banner));
    }).toList();
    json['products'].map((product) {
      products.add(ProductModel.fromJson(product));
    }).toList();
  }
  Map<String, dynamic> toJson({HomeData? model}) {
    if (model != null) {
      return {
        'banners': model.banners
            .map(
              (banner) => banner.toJson(model: banner),
            )
            .toList(),
        'products': model.products.map((product) => product.toJson(model: product)).toList(),
      };
    } else {
      return {
        'banners': banners.map((banner) => banner.toJson()).toList(),
        'products': products.map((product) => product.toJson()).toList(),
      };
    }
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
  Map<String, dynamic> toJson({BannerModel? model}) {
    if (model != null) {
      return {
        'id': model.id,
        'image': model.imageUrl,
        'category': model.category,
        'product': model.product,
      };
    } else {
      return {
        'id': id,
        'image': imageUrl,
        'category': category,
        'product': product,
      };
    }
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

  Map<String, dynamic>? toJson({ProductModel? model}) {
    if (model != null) {
      return {
        'id': model.id,
        'name': model.name,
        'image': model.imageUrl,
        'price': model.price,
        'old_price': model.oldPrice,
        'discount': model.discount,
        'in_favorites': model.inFavorites,
        'in_cart': model.inCart,
      };
    } else {
      return {
        'id': id,
        'name': name,
        'image': imageUrl,
        'price': price,
        'old_price': oldPrice,
        'discount': discount,
        'in_favorites': inFavorites,
        'in_cart': inCart,
      };
    }
  }
}
