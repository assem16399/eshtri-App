import 'package:bloc/bloc.dart';
import 'package:eshtri/models/home_model.dart';
import 'package:eshtri/modules/home/cubit/home_states.dart';
import 'package:eshtri/shared/network/end_points.dart';
import 'package:eshtri/shared/network/remote/dio_helper.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  HomeModel? homeModel;

  void getHomeData(String token) async {
    emit(HomeLoadingState());
    try {
      final response = await DioHelper.getRequest(path: kHomeEndPoint, token: token);
      homeModel = HomeModel.fromJson(response.data);
      if (homeModel!.status) {
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
