import 'package:eshtri/modules/register/register_screen.dart';
import 'package:eshtri/shared/styles/colors.dart';
import 'package:flutter/material.dart';

import 'default_text_filed.dart';

enum AuthMode { login, signup, forgetPassword }

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key, this.currentAuthMode = AuthMode.login}) : super(key: key);
  final AuthMode currentAuthMode;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  var _isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Form(
      child: SingleChildScrollView(
        child: Column(
          children: [
            DefaultTextField(
              label: 'Email',
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
            ),
            const AuthButton(),
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
                    widget.currentAuthMode == AuthMode.login ? 'Register Now.' : 'Login',
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

class AuthButton extends StatelessWidget {
  const AuthButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Text(
        'LOGIN',
        style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.white),
      ),
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(
          const Size(double.infinity, 50),
        ),
      ),
    );
  }
}
