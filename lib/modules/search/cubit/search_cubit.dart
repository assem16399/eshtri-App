import 'package:bloc/bloc.dart';
import 'package:eshtri/models/category_products_model.dart';
import 'package:eshtri/models/single_product/single_product_model.dart';
import 'package:eshtri/modules/search/cubit/search_states.dart';
import 'package:eshtri/shared/components/constants/constants.dart';
import 'package:eshtri/shared/components/toast.dart';
import 'package:eshtri/shared/network/end_points.dart';
import 'package:eshtri/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  CategoryProductsModel? _searchedProductsModel;

  List<SingleProductModel>? get searchedProducts {
    if (_searchedProductsModel == null) return [];
    if (_searchedProductsModel!.data == null) return [];
    return CategoryProductsModel.copy(_searchedProductsModel!).data!.products;
  }

  Future<void> searchForProducts(String searchKey) async {
    emit(SearchLoadingState());
    _searchedProductsModel = null;
    try {
      final response = await DioHelper.postRequest(
          path: kProductsSearchEndpoint, data: {'text': searchKey}, token: userAccessToken);
      if (response.data['status']) {
        _searchedProductsModel = CategoryProductsModel.fromJson(response.data);
        emit(SearchSuccessState());
        print('token for getting searched products is: $userAccessToken');
        if (_searchedProductsModel!.data!.products.isEmpty) {
          toast(toastMsg: 'Could not find any results');
        }
      } else {
        emit(SearchFailState());
      }
    } catch (error) {
      emit(SearchFailState());
    }
  }
}
