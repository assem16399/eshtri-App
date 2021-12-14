import 'package:bloc/bloc.dart';
import 'package:eshtri/models/categories_model.dart';
import 'package:eshtri/modules/categories/cubit/categories_states.dart';
import 'package:eshtri/shared/components/constants/constants.dart';
import 'package:eshtri/shared/network/end_points.dart';
import 'package:eshtri/shared/network/remote/dio_helper.dart';

class CategoriesCubit extends Cubit<CategoriesStates> {
  CategoriesCubit() : super(CategoriesInitialState());

  CategoriesModel? _categoriesModel;
  CategoriesModel? get categoriesModel {
    if (_categoriesModel != null) {
      return CategoriesModel.copy(_categoriesModel!);
    }
    return null;
  }

  String? tempToken;

  Future<void> getCategories([bool forceRefresh = false]) async {
    if (tempToken == null || forceRefresh == true) {
      emit(CategoriesLoadingState());

      try {
        final response = await DioHelper.getRequest(path: kGetCategoriesEndpoint);

        if (CategoriesModel.fromJson(response!.data).status) {
          _categoriesModel = CategoriesModel.fromJson(response.data);
          tempToken = userAccessToken;
          emit(CategoriesGetSuccessState());
        } else {
          print('error');
          emit(CategoriesGetFailState());
        }
      } catch (error) {
        print(error.toString());

        emit(CategoriesGetFailState());
      }
    } else {
      if (tempToken != userAccessToken) {
        emit(CategoriesLoadingState());

        try {
          final response = await DioHelper.getRequest(path: kGetCategoriesEndpoint);

          if (CategoriesModel.fromJson(response!.data).status) {
            _categoriesModel = CategoriesModel.fromJson(response.data);
            tempToken = userAccessToken;

            emit(CategoriesGetSuccessState());
          } else {
            print('error');
            emit(CategoriesGetFailState());
          }
        } catch (error) {
          print(error.toString());

          emit(CategoriesGetFailState());
        }
      }
    }
  }
}
