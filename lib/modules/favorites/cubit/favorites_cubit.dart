import 'package:bloc/bloc.dart';
import 'package:eshtri/models/favorites_model.dart';
import 'package:eshtri/modules/favorites/cubit/favorites_states.dart';
import 'package:eshtri/shared/components/constants/constants.dart';
import 'package:eshtri/shared/network/end_points.dart';
import 'package:eshtri/shared/network/remote/dio_helper.dart';

class FavoritesCubit extends Cubit<FavoritesStates> {
  FavoritesCubit() : super(FavoritesInitialState());

  FavoritesModel? _favoritesModel;

  List<FavoritesData> get favoriteProducts {
    if (_favoritesModel == null) return [];
    if (_favoritesModel!.data == null) return [];
    return _favoritesModel!.data!.data
        .where((element) => element.singleProductModel.inFavorites)
        .toList();
  }

  void getFavoriteProducts() async {
    emit(FavoritesLoadingState());
    try {
      final response =
          await DioHelper.getRequest(path: kGetFavoriteStatusEndpoint, token: userAccessToken);
      if (response!.data['status']) {
        _favoritesModel = FavoritesModel.fromJson(response.data);
        emit(FavoritesGetSuccessState());
      } else {
        emit(FavoritesGetFailState());
      }
    } catch (error) {
      print(error.toString());

      emit(FavoritesGetFailState());
    }
  }

  void refreshFavoriteList() {
    emit(FavoritesRefreshState());
  }
}
