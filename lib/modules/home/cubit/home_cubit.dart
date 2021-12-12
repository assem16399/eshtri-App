import 'package:bloc/bloc.dart';
import 'package:eshtri/models/home_model.dart';
import 'package:eshtri/models/single_product/single_product_model.dart';
import 'package:eshtri/modules/home/cubit/home_states.dart';
import 'package:eshtri/shared/network/end_points.dart';
import 'package:eshtri/shared/network/remote/dio_helper.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  late HomeModel? _homeModel;

  final List<SingleProductModel> _products = [];
  final List<BannerModel> _banners = [];

  List<SingleProductModel> get products {
    return [..._products];
  }

  SingleProductModel findProductById(int id) {
    return _products.firstWhere((element) => element.id == id);
  }

  List<BannerModel> get banners {
    return [..._banners];
  }

  void getHomeData(String token) async {
    emit(HomeLoadingState());
    try {
      final response = await DioHelper.getRequest(path: kHomeEndpoint, token: token);
      if (HomeModel.fromJson(response!.data).status) {
        _homeModel = HomeModel.fromJson(response.data);
        for (var element in _homeModel!.data!.products) {
          _products.add(element);
        }
        for (var element in _homeModel!.data!.banners) {
          _banners.add(element);
        }

        _homeModel = null;
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
