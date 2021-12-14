import 'package:eshtri/modules/about_us/about_us_screen.dart';
import 'package:eshtri/modules/auth/cubit/auth_cubit.dart';
import 'package:eshtri/modules/auth/login/login_screen.dart';
import 'package:eshtri/modules/profile/profile_screen.dart';
import 'package:eshtri/modules/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileAndMoreTab extends StatelessWidget {
  const ProfileAndMoreTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(ProfileScreen.routeName);
              },
              child: ListTile(
                leading: const Icon(Icons.person),
                title: Text(
                  'Profile',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                trailing: const Icon(Icons.navigate_next_outlined),
              ),
            ),
            const Divider(
              thickness: 2,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(SettingsScreen.routeName);
              },
              child: ListTile(
                leading: const Icon(Icons.settings),
                title: Text(
                  'Settings',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                trailing: const Icon(Icons.navigate_next_outlined),
              ),
            ),
            const Divider(
              thickness: 2,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(AboutUsScreen.routeName);
              },
              child: ListTile(
                leading: const Icon(Icons.info),
                title: Text(
                  'About Us',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                trailing: const Icon(Icons.navigate_next_outlined),
              ),
            ),
            const Divider(
              thickness: 2,
            ),
            InkWell(
              onTap: () async {
                try {
                  await BlocProvider.of<AuthCubit>(context).logTheUserOut();
                  Navigator.of(context).pushReplacementNamed('/');
                } catch (_) {}
              },
              child: ListTile(
                leading: const Icon(Icons.logout_outlined),
                title: Text(
                  'LOGOUT',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                trailing: const Icon(Icons.navigate_next_outlined),
              ),
            ),
            const Divider(
              thickness: 2,
            ),
          ],
        ),
      ),
    );
  }
}
