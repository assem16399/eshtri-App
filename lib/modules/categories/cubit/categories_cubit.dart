import 'package:bloc/bloc.dart';
import 'package:eshtri/models/categories_model.dart';
import 'package:eshtri/modules/categories/cubit/categories_states.dart';
import 'package:eshtri/shared/network/end_points.dart';
import 'package:eshtri/shared/network/remote/dio_helper.dart';

class CategoriesCubit extends Cubit<CategoriesStates> {
  CategoriesCubit() : super(CategoriesInitialState());

  CategoriesModel? _categoriesModel;
  CategoriesModel? get categoriesModel {
    if (_categoriesModel != null) {
      return CategoriesModel.fromJson(_categoriesModel!.toJson());
    }
    return null;
  }

  void getCategories() async {
    emit(CategoriesLoadingState());

    try {
      final response = await DioHelper.getRequest(path: kGetCategoriesEndpoint);

      if (CategoriesModel.fromJson(response!.data).status) {
        _categoriesModel = CategoriesModel.fromJson(response.data);
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
