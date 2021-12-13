import 'package:bloc/bloc.dart';
import 'package:eshtri/models/login_model.dart';
import 'package:eshtri/shared/components/constants/constants.dart';
import 'package:eshtri/shared/network/end_points.dart';
import 'package:eshtri/shared/network/remote/dio_helper.dart';

import 'profile_states.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(ProfileInitialState());

  LoginModel? _loginModel;

  LoginModel? get profileModel {
    if (_loginModel == null) return null;
    return LoginModel.copy(_loginModel!);
  }

  void getProfileData() async {
    emit(ProfileDataLoadingState());
    try {
      final response =
          await DioHelper.getRequest(path: kGetProfileDataEndpoint, token: userAccessToken);
      if (LoginModel.fromJson(response!.data).status) {
        _loginModel = LoginModel.fromJson(response.data);

        emit(ProfileGetDataSuccessState());
      } else {
        emit(ProfileGetDataFailState());
      }
    } catch (error) {
      print(error.toString());
      emit(ProfileGetDataFailState());
    }
  }

  // void getProfileData() async {
  //   emit(ProfileDataLoadingState());
  //
  //   final response =
  //       await DioHelper.getRequest(path: kGetProfileDataEndpoint, token: userAccessToken);
  //   if (LoginModel.fromJson(response!.data).status) {
  //     _loginModel = LoginModel.fromJson(response.data);
  //     print(_loginModel!.data!.email);
  //     emit(ProfileGetDataSuccessState());
  //   } else {
  //     emit(ProfileGetDataFailState());
  //   }
  // }
}
