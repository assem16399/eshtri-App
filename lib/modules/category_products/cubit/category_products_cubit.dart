import 'package:bloc/bloc.dart';
import 'package:eshtri/models/category_products_model.dart';
import 'package:eshtri/models/single_product/single_product_model.dart';
import 'package:eshtri/modules/category_products/cubit/category_products_states.dart';
import 'package:eshtri/shared/components/constants/constants.dart';
import 'package:eshtri/shared/network/end_points.dart';
import 'package:eshtri/shared/network/remote/dio_helper.dart';

class CategoryProductsCubit extends Cubit<CategoryProductsStates> {
  CategoryProductsCubit() : super(CategoryProductsInitialState());

  CategoryProductsModel? _categoryProductsModel;

  List<SingleProductModel> get categoryProductsModel {
    if (_categoryProductsModel == null) return [];
    if (_categoryProductsModel!.data == null) return [];
    return CategoryProductsModel.copy(_categoryProductsModel!).data!.products.toList();
  }

  List<SingleProductModel> get favProducts {
    if (_categoryProductsModel == null) return [];
    if (_categoryProductsModel!.data == null) return [];
    return _categoryProductsModel!.data!.products
        .where((element) => element.inFavorites == true)
        .toList();
  }

  void refreshCategoryProductsFavoriteStatus([int? updatedProductId]) {
    if (updatedProductId == null) {
      emit(ChangeProductFavoriteStatus());
      return;
    } else {
      final updatedProductIndex = _categoryProductsModel!.data!.products
          .indexWhere((element) => element.id == updatedProductId);
      if (updatedProductIndex == -1) return;
      _categoryProductsModel!.data!.products[updatedProductIndex].inFavorites =
          !_categoryProductsModel!.data!.products[updatedProductIndex].inFavorites;
      emit(ChangeProductFavoriteStatus());
    }
  }

  int? tempCategoryId;
  String? tempToken;

  void getCategoryProducts({required int categoryId, bool forceRefresh = false}) async {
    if (tempToken == null ||
        tempToken != userAccessToken ||
        forceRefresh ||
        tempCategoryId != categoryId) {
      emit(CategoryProductsLoadingState());
      try {
        final response = await DioHelper.getRequest(
          path: kGetCategoryProductsEndpoint,
          queryParameters: {'category_id': categoryId},
          token: userAccessToken,
        );
        if (response!.data['status']) {
          _categoryProductsModel = CategoryProductsModel.fromJson(response.data);
          print(_categoryProductsModel!.data!.products[0].name);
          tempToken = userAccessToken;
          tempCategoryId = categoryId;
          emit(CategoryProductsGetSuccessState());
        } else {
          emit(CategoryProductsGetFailState());
        }
      } catch (error) {
        emit(CategoryProductsGetFailState());
      }
    }
  }
}
