import 'package:eshtri/layout/home_layout.dart';
import 'package:eshtri/modules/login/cubit/login_cubit.dart';
import 'package:eshtri/modules/login/cubit/login_states.dart';
import 'package:eshtri/modules/register/register_screen.dart';

import 'package:eshtri/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_button.dart';
import 'default_text_filed.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  var loginData = <String, String>{
    'email': '',
    'password': '',
  };
  var _isPasswordVisible = false;
  final formKey = GlobalKey<FormState>();

  void submitLoginForm() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      BlocProvider.of<LoginCubit>(context, listen: false)
          .logUserIn(loginData['email']!, loginData['password']!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            DefaultTextField(
              label: 'Email',
              onSaved: (value) {
                loginData['email'] = value!;
              },
              preIcon: Icons.email_outlined,
              type: TextInputType.emailAddress,
              validator: (value) {
                if (value!.isEmpty) return 'Please Enter Your Email Address!';
                if (!value.contains('@') && !value.contains('.')) {
                  return 'Please Enter a valid Email!';
                }
                return null;
              },
            ),
            DefaultTextField(
              label: 'Password',
              preIcon: Icons.lock_outline,
              sufIcon: _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              type: TextInputType.emailAddress,
              isVisible: _isPasswordVisible,
              onSuffixIconTap: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
              validator: (value) {
                if (value!.isEmpty) return 'Please Enter Your Password!';
                if (value.length < 6) {
                  return 'password must be more than 5 characters';
                }
                return null;
              },
              onSaved: (value) {
                loginData['password'] = value!;
              },
              onSubmit: (_) {
                submitLoginForm();
              },
            ),
            BlocConsumer<LoginCubit, LoginStates>(
              listener: (context, loginState) {
                if (loginState is LoginSuccessState) {
                  Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(builder: (context) => const HomeLayout()));
                }
              },
              builder: (context, loginState) {
                return loginState is! LoginLoadingState
                    ? AuthButton(
                        title: 'LOGIN',
                        onPressed: submitLoginForm,
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      );
              },
            ),
            SizedBox(
              height: deviceSize.height * 0.01,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Don\'t have an account?',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 15),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const RegisterScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'Register Now.',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 15, color: kPrimarySwatchColor),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
