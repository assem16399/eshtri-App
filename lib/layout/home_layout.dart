import 'package:eshtri/modules/login/cubit/login_cubit.dart';
import 'package:eshtri/modules/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  _HomeLayoutState createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: TextButton(
          onPressed: () async {
            await BlocProvider.of<LoginCubit>(context).logTheUserOut();
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) => const LoginScreen()));
          },
          child: const Text('Logout'),
        ),
      ),
    );
  }
}
