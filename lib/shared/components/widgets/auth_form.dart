import 'package:eshtri/layout/home_layout.dart';
import 'package:eshtri/modules/auth/auth_mode_enum.dart';
import 'package:eshtri/modules/auth/cubit/auth_cubit.dart';
import 'package:eshtri/modules/auth/cubit/auth_states.dart';

import 'package:eshtri/modules/auth/register/register_screen.dart';

import 'package:eshtri/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_button.dart';
import 'default_text_filed.dart';

class AuthForm extends StatefulWidget {
  final AuthMode currentAuthMode;
  const AuthForm({
    this.currentAuthMode = AuthMode.login,
    Key? key,
  }) : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _passwordController = TextEditingController();
  var authData = <String, String?>{};
  var _isPasswordVisible = false;
  final formKey = GlobalKey<FormState>();

  void submitAuthForm() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      if (widget.currentAuthMode == AuthMode.login) {
        BlocProvider.of<AuthCubit>(context, listen: false)
            .logUserIn(authData['email']!, authData['password']!);
      } else {
        // TODO Register the user here...
        BlocProvider.of<AuthCubit>(context, listen: false).registerTheUser(
            email: authData['email']!,
            password: authData['password']!,
            name: authData['name']!,
            phone: authData['phone']!);
      }
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
            if (widget.currentAuthMode == AuthMode.register)
              DefaultTextField(
                label: 'Name',
                onSaved: (value) {
                  authData['name'] = value!;
                },
                preIcon: Icons.person,
                type: TextInputType.name,
                validator: (value) {
                  if (value!.isEmpty) return 'Please Enter Your Full Name!';

                  return null;
                },
              ),
            DefaultTextField(
              label: 'Email',
              onSaved: (value) {
                authData['email'] = value!;
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
            if (widget.currentAuthMode == AuthMode.register)
              DefaultTextField(
                label: 'Phone',
                onSaved: (value) {
                  authData['phone'] = value!;
                },
                preIcon: Icons.phone,
                type: TextInputType.phone,
                validator: (value) {
                  if (value!.isEmpty) return 'Please Enter Your Phone!';
                  return null;
                },
              ),
            DefaultTextField(
              controller: _passwordController,
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
                authData['password'] = value!;
              },
              onSubmit: (_) {
                if (widget.currentAuthMode == AuthMode.login) {
                  submitAuthForm();
                }
              },
            ),
            if (widget.currentAuthMode == AuthMode.register)
              DefaultTextField(
                label: 'Confirm Password',
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
                  if (value != _passwordController.text) return 'Password didn\'t match!';
                  return null;
                },
                onSubmit: (_) {
                  submitAuthForm();
                },
              ),
            BlocConsumer<AuthCubit, AuthStates>(
              listener: (context, authState) {
                if (authState is AuthSuccessState) {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const HomeLayout(),
                      ),
                      (route) => false);
                }
              },
              builder: (context, loginState) {
                return loginState is! AuthLoadingState
                    ? AuthButton(
                        title: widget.currentAuthMode == AuthMode.login ? 'LOGIN' : 'REGISTER',
                        onPressed: submitAuthForm,
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
                  widget.currentAuthMode == AuthMode.login
                      ? 'Don\'t have an account?'
                      : 'Already have an account?',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 15),
                ),
                TextButton(
                  onPressed: () {
                    if (widget.currentAuthMode == AuthMode.login) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const RegisterScreen(),
                        ),
                      );
                    } else {
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text(
                    widget.currentAuthMode == AuthMode.login ? 'Register Now.' : 'Login Instead.',
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
