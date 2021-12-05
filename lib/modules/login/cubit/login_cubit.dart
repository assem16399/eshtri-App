import 'package:bloc/bloc.dart';
import 'package:eshtri/models/login_model.dart';
import 'package:eshtri/modules/login/cubit/login_states.dart';
import 'package:eshtri/shared/network/end_points.dart';
import 'package:eshtri/shared/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  void logUserIn(String email, String password) async {
    emit(LoginLoadingState());
    try {
      final response = await DioHelper.postRequest(
          path: kLoginEndPoint, data: {'email': email, 'password': password});
      final loginModel = LoginModel.fromJson(response.data);
      emit(LoginSuccessState());
      print(loginModel.data!.name);
      print(loginModel.message);
      print(loginModel.status);
    } catch (error) {
      emit(LoginFailState());
      print(error.toString());
    }
  }
}
