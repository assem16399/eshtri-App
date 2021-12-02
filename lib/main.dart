import 'package:eshtri/shared/cubit/app_cubit.dart';
import 'package:eshtri/shared/cubit/app_states.dart';
import 'package:eshtri/shared/styles/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'modules/on_boarding/on_boarding_screen.dart';
import 'shared/components/constants/bloc_observer.dart';
import 'shared/network/local/cache_helper.dart';
import 'shared/network/remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();
  await CacheHelper.init();

  final mode = CacheHelper.getSavedDataInPref();
  BlocOverrides.runZoned(
    () {
      runApp(MyApp(
        sharedPrefIsDark: mode,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final bool? sharedPrefIsDark;
  const MyApp({Key? key, this.sharedPrefIsDark}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppCubit()..toggleThemeMode(sharedPrefIsDark)),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, appState) {},
        builder: (context, appState) => MaterialApp(
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: BlocProvider.of<AppCubit>(context).isDark ? ThemeMode.dark : ThemeMode.light,
          title: 'Flutter Demo',
          home: OnBoardingScreen(),
        ),
      ),
    );
  }
}
