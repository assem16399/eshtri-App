class CategoriesModel {
  late final bool status;
  late final CategoriesData? data;
  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? CategoriesData.fromJson(json['data']) : null;
  }

  CategoriesModel.copy(CategoriesModel model) {
    status = model.status;
    data = CategoriesData.copy(model.data!);
  }
}

class CategoriesData {
  late final int currentPage;
  final List<CategoryModel> categories = [];

  CategoriesData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((category) => categories.add(CategoryModel.fromJson(category)));
  }
  CategoriesData.copy(CategoriesData model) {
    currentPage = model.currentPage;
    for (var category in model.categories) {
      categories.add(CategoryModel.copy(category));
    }
  }
}

class CategoryModel {
  late final dynamic id;
  late final String name;
  late final String imageUrl;

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageUrl = json['image'];
  }

  CategoryModel.copy(CategoryModel model) {
    id = model.id;
    name = model.name;
    imageUrl = model.imageUrl;
  }
}
