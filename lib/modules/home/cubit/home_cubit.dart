import 'package:bloc/bloc.dart';
import 'package:eshtri/models/home_model.dart';
import 'package:eshtri/models/single_product/single_product_model.dart';
import 'package:eshtri/modules/home/cubit/home_states.dart';
import 'package:eshtri/shared/components/constants/constants.dart';
import 'package:eshtri/shared/network/end_points.dart';
import 'package:eshtri/shared/network/remote/dio_helper.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  HomeModel? _homeModel;
  HomeModel? get homeModel {
    if (_homeModel == null) return null;
    return HomeModel.copy(_homeModel!);
  }

  List<SingleProductModel> get favProducts {
    if (_homeModel == null) return [];
    return _homeModel!.data!.products.where((element) => element.inFavorites == true).toList();
  }

  SingleProductModel findProductById(int id) {
    return _homeModel!.data!.products.firstWhere((element) => element.id == id);
  }

  void refreshFavoriteList() {
    emit(ChangeProductFavoriteStatus());
  }

  String? tempToken;
  Future<void> getHomeData([bool forceRefresh = false]) async {
    if (tempToken == null || forceRefresh == true || tempToken != userAccessToken) {
      // get the data
      emit(HomeLoadingState());
      try {
        final response = await DioHelper.getRequest(path: kHomeEndpoint);
        if (HomeModel.fromJson(response!.data).status) {
          _homeModel = HomeModel.fromJson(response.data);

          //Assign user token to the tempToken
          tempToken = userAccessToken;

          emit(HomeSuccessState());
        } else {
          print('error in getting Data');
          emit(HomeFailState());
        }
      } catch (error) {
        print(error.toString());
        emit(HomeFailState());
      }
    }
  }
}
