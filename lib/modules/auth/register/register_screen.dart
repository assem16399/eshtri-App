import 'package:eshtri/modules/auth/auth_mode_enum.dart';
import 'package:eshtri/shared/components/widgets/auth_form.dart';
import 'package:eshtri/shared/styles/colors.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Register',
                  style:
                      Theme.of(context).textTheme.headline4!.copyWith(color: kPrimarySwatchColor),
                ),
                SizedBox(
                  height: deviceSize.height * 0.01,
                ),
                Text(
                  'Register now to get the best shopping experience',
                  style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.black),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 16.0),
                  child: AuthForm(
                    currentAuthMode: AuthMode.register,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
