import 'package:eshtri/modules/profile_and_more/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileAndMoreTab extends StatelessWidget {
  const ProfileAndMoreTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileData = BlocProvider.of<ProfileCubit>(context, listen: true).profileModel;
    return Center(
      child: profileData == null ? const CircularProgressIndicator() : const Text('Settings Tab'),
    );
  }
}
