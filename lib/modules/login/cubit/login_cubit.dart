import 'package:bloc/bloc.dart';
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
      emit(LoginSuccessState());
      print(response.data);
    } catch (error) {
      emit(LoginFailState());
      print(error.toString());
    }
  }
}
