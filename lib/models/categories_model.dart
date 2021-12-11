class CategoriesModel {
  late final bool status;
  late CategoriesData data;
  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = (json['data'] != null ? CategoriesData.fromJson(json['data']) : null)!;
  }

  Map<String, dynamic> toJson({CategoriesModel? model}) {
    if (model != null) {
      return {'status': model.status, 'data': model.data.toJson(model: model.data)};
    } else {
      return {'status': status, 'data': data.toJson()};
    }
  }
}

class CategoriesData {
  late final int currentPage;
  List<CategoryModel> categories = [];

  CategoriesData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].map((category) => categories.add(CategoryModel.fromJson(json))).toList();
  }

  Map<String, dynamic> toJson({CategoriesData? model}) {
    if (model != null) {
      return {
        'current_page': model.currentPage,
        'data': model.categories.map((category) => category.toJson(model: category)).toList()
      };
    } else {
      return {
        'current_page': currentPage,
        'data': categories.map((category) => category.toJson()).toList()
      };
    }
  }
}

class CategoryModel {
  late final int id;
  late final String name;
  late final String imageUrl;

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageUrl = json['image'];
  }

  Map<String, dynamic> toJson({CategoryModel? model}) {
    if (model != null) {
      return {
        'id': model.id,
        'name': model.name,
        'image': model.imageUrl,
      };
    } else {
      return {
        'id': id,
        'name': name,
        'image': imageUrl,
      };
    }
  }
}
