import 'package:bloc/bloc.dart';
import 'package:eshtri/models/login_model.dart';
import 'package:eshtri/modules/login/cubit/login_states.dart';
import 'package:eshtri/shared/components/toast.dart';
import 'package:eshtri/shared/network/end_points.dart';
import 'package:eshtri/shared/network/local/cache_helper.dart';
import 'package:eshtri/shared/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());
  void logUserIn(String email, String password) async {
    emit(LoginLoadingState());
    try {
      final response = await DioHelper.postRequest(
          path: kLoginEndPoint, data: {'email': email, 'password': password});

      final LoginModel loginModel = LoginModel.fromJson(response.data);

      if (loginModel.status) {
        toast(toastMsg: loginModel.message);
        emit(LoginSuccessState());
        CacheHelper.setData(key: 'token', value: loginModel.data!.token);
      } else {
        toast(toastMsg: loginModel.message);
        emit(LoginFailState());
      }
    } catch (error) {
      emit(LoginFailState());
    }
  }

  Future<void> logTheUserOut() async {
    await CacheHelper.clear('token');

    emit(LoginKillTokenState());
  }
}
