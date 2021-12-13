import 'package:eshtri/modules/about_us/about_us_screen.dart';
import 'package:eshtri/modules/profile/profile_screen.dart';
import 'package:eshtri/modules/settings/settings.dart';
import 'package:flutter/material.dart';

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
          ],
        ),
      ),
    );
  }
}
