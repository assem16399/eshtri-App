import 'package:eshtri/layout/home_layout.dart';
import 'package:eshtri/modules/about_us/about_us_screen.dart';
import 'package:eshtri/modules/categories/cubit/categories_cubit.dart';
import 'package:eshtri/modules/home/cubit/home_cubit.dart';
import 'package:eshtri/modules/auth/login/login_screen.dart';
import 'package:eshtri/modules/search/search_screen.dart';
import 'package:eshtri/modules/settings/settings.dart';
import 'package:eshtri/shared/components/constants/constants.dart';
import 'package:eshtri/shared/cubit/app_cubit.dart';
import 'package:eshtri/shared/cubit/app_states.dart';
import 'package:eshtri/shared/styles/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'modules/auth/cubit/auth_cubit.dart';
import 'modules/auth/cubit/auth_states.dart';
import 'modules/on_boarding/on_boarding_screen.dart';
import 'modules/profile/cubit/profile_cubit.dart';
import 'modules/profile/profile_screen.dart';
import 'shared/components/constants/bloc_observer.dart';
import 'shared/network/local/cache_helper.dart';
import 'shared/network/remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();
  await CacheHelper.init();

  final mode = CacheHelper.getData(key: 'themeMode');
  final boarded = CacheHelper.getData(key: 'boarded');
  userAccessToken = CacheHelper.getData(key: 'token');

  BlocOverrides.runZoned(
    () {
      runApp(MyApp(
        boarded: boarded ?? false,
        sharedPrefIsDark: mode,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final bool? sharedPrefIsDark;
  final bool boarded;
  const MyApp({
    Key? key,
    this.sharedPrefIsDark,
    required this.boarded,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit()..toggleThemeMode(sharedPrefIsDark),
        ),
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => HomeCubit(),
        ),
        BlocProvider(
          create: (context) => CategoriesCubit(),
        ),
        BlocProvider(
          create: (context) => ProfileCubit(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, appState) {},
        builder: (context, appState) {
          return BlocConsumer<AuthCubit, AuthStates>(
            listener: (context, appState) {},
            builder: (context, appState) => MaterialApp(
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode:
                  BlocProvider.of<AppCubit>(context).isDark ? ThemeMode.dark : ThemeMode.light,
              title: 'Flutter Demo',
              home: boarded
                  ? BlocProvider.of<AuthCubit>(context).hasToken
                      ? const HomeLayout()
                      : BlocProvider.of<AuthCubit>(context).tryAutoLogin()
                          ? const HomeLayout()
                          : const LoginScreen()
                  : OnBoardingScreen(),
              routes: {
                SearchScreen.routeName: (context) => SearchScreen(),
                ProfileScreen.routeName: (context) => const ProfileScreen(),
                SettingsScreen.routeName: (context) => const SettingsScreen(),
                AboutUsScreen.routeName: (context) => const AboutUsScreen(),
              },
            ),
          );
        },
      ),
    );
  }
}
