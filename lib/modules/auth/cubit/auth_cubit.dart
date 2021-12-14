import 'package:bloc/bloc.dart';
import 'package:eshtri/models/login_model.dart';
import 'package:eshtri/modules/auth/cubit/auth_states.dart';
import 'package:eshtri/shared/components/constants/constants.dart';
import 'package:eshtri/shared/components/toast.dart';
import 'package:eshtri/shared/network/end_points.dart';
import 'package:eshtri/shared/network/local/cache_helper.dart';
import 'package:eshtri/shared/network/remote/dio_helper.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitialState());

  AuthModel? _authModel;
  void logUserIn(String email, String password) async {
    emit(AuthLoadingState());
    try {
      final response = await DioHelper.postRequest(
          path: kLoginEndpoint, data: {'email': email, 'password': password});

      _authModel = AuthModel.fromJson(response.data);

      if (_authModel!.status) {
        toast(toastMsg: _authModel!.message);
        emit(AuthSuccessState());
        userAccessToken = _authModel!.data!.token;
        CacheHelper.setData(key: 'token', value: userAccessToken);
      } else {
        toast(toastMsg: _authModel!.message);
        emit(AuthFailState());
      }
    } catch (error) {
      emit(AuthFailState());
    }
  }

  void registerTheUser(
      {required String email,
      required String password,
      required String phone,
      required String name}) async {
    emit(AuthLoadingState());
    try {
      final response = await DioHelper.postRequest(
          path: kRegisterEndpoint,
          data: {'email': email, 'password': password, 'name': name, 'phone': phone});

      _authModel = AuthModel.fromJson(response.data);
      if (_authModel!.status) {
        toast(toastMsg: _authModel!.message);
        emit(AuthSuccessState());
        userAccessToken = _authModel!.data!.token;
        CacheHelper.setData(key: 'token', value: userAccessToken);
      } else {
        toast(toastMsg: _authModel!.message);
        emit(AuthFailState());
      }
    } catch (error) {
      emit(AuthFailState());
    }
  }

  Future<void> logTheUserOut() async {
    try {
      final response =
          await DioHelper.postRequest(path: kLogoutEndpoint, data: {}, token: userAccessToken);
      if (response.data['status']) {
        await CacheHelper.clear('token');
        _authModel = null;
        userAccessToken = null;
        toast(toastMsg: response.data['message']);
        emit(AuthKillTokenState());
      } else {
        toast(toastMsg: response.data['message']);
        emit(AuthUnableToKillTokenState());
        throw 'Something went wrong';
      }
    } catch (error) {
      emit(AuthUnableToKillTokenState());
      rethrow;
    }
  }
}
