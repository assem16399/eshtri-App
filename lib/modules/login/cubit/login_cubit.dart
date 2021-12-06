import 'package:bloc/bloc.dart';
import 'package:eshtri/models/login_model.dart';
import 'package:eshtri/modules/login/cubit/login_states.dart';
import 'package:eshtri/shared/network/end_points.dart';
import 'package:eshtri/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  void logUserIn(String email, String password) async {
    emit(LoginLoadingState());
    try {
      final response = await DioHelper.postRequest(
          path: kLoginEndPoint, data: {'email': email, 'password': password});
      final loginModel = LoginModel.fromJson(response.data);
      if (loginModel.status) {
        Fluttertoast.showToast(
            msg: loginModel.message,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        emit(LoginSuccessState());
      } else {
        Fluttertoast.showToast(
            msg: loginModel.message,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        emit(LoginFailState());
      }
    } catch (error) {
      emit(LoginFailState());
    }
  }
}
