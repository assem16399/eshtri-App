import 'package:bloc/bloc.dart';
import 'package:eshtri/models/login_model.dart';
import 'package:eshtri/shared/components/constants/constants.dart';
import 'package:eshtri/shared/components/toast.dart';
import 'package:eshtri/shared/network/end_points.dart';
import 'package:eshtri/shared/network/remote/dio_helper.dart';

import 'profile_states.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(ProfileInitialState());

  AuthModel? _profileModel;

  AuthModel? get profileModel {
    if (_profileModel == null) return null;
    return AuthModel.copy(_profileModel!);
  }

  String? tempToken;
  Future<void> getProfileData([bool forceRefresh = false]) async {
    if (tempToken == null || forceRefresh == true) {
      emit(ProfileDataLoadingState());
      try {
        final response =
            await DioHelper.getRequest(path: kGetProfileDataEndpoint, token: userAccessToken);
        if (AuthModel.fromJson(response!.data).status) {
          _profileModel = AuthModel.fromJson(response.data);
          tempToken = userAccessToken;
          emit(ProfileGetDataSuccessState());
        } else {
          emit(ProfileGetDataFailState());
        }
      } catch (error) {
        print(error.toString());
        emit(ProfileGetDataFailState());
      }
    } else {
      if (tempToken != userAccessToken) {
        emit(ProfileDataLoadingState());
        try {
          final response =
              await DioHelper.getRequest(path: kGetProfileDataEndpoint, token: userAccessToken);
          if (AuthModel.fromJson(response!.data).status) {
            _profileModel = AuthModel.fromJson(response.data);
            tempToken = userAccessToken;
            emit(ProfileGetDataSuccessState());
          } else {
            emit(ProfileGetDataFailState());
          }
        } catch (error) {
          emit(ProfileGetDataFailState());
          rethrow;
        }
      }
    }
  }

  Future<void> updateUserProfile(UserData data) async {
    emit(ProfileUpdateLoadingState());
    try {
      final response = await DioHelper.putRequest(
          path: kUpdateProfileDataEndpoint,
          data: {
            'name': data.name,
            'phone': data.phone,
            'email': data.email,
            'image': data.image,
          },
          token: userAccessToken);
      if (response.data['status']) {
        _profileModel = _profileModel!.copyWith(data: data);
        toast(toastMsg: response.data['message']);
        emit(ProfileUpdateSuccessState());
      } else {
        emit(ProfileUpdateFailState());
        throw response.data['message']!;
      }
    } catch (error) {
      print(error.toString());
      emit(ProfileUpdateFailState());
      rethrow;
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
