import 'package:eshtri/modules/profile/cubit/profile_cubit.dart';
import 'package:eshtri/shared/components/widgets/default_text_filed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  static const routeName = '/profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final formKey = GlobalKey<FormState>();
  var _enabled = false;
  @override
  Widget build(BuildContext context) {
    final profileModel = BlocProvider.of<ProfileCubit>(context, listen: true).profileModel;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Profile'),
      ),
      body: profileModel == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Form(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                            profileModel.data!.image,
                          ),
                        ),
                      ),
                      DefaultTextField(
                        enabled: _enabled,
                        initialValue: profileModel.data!.name,
                        type: TextInputType.name,
                        label: 'Your Name',
                        preIcon: Icons.face_rounded,
                        validator: (String? value) {},
                      ),
                      DefaultTextField(
                        enabled: _enabled,
                        initialValue: profileModel.data!.email,
                        type: TextInputType.emailAddress,
                        label: 'Your Email',
                        preIcon: Icons.email_outlined,
                        validator: (String? value) {},
                      ),
                      DefaultTextField(
                        enabled: _enabled,
                        initialValue: profileModel.data!.phone,
                        type: TextInputType.phone,
                        label: 'Your Phone',
                        preIcon: Icons.phone,
                        validator: (String? value) {},
                      ),
                      DefaultTextField(
                        enabled: _enabled,
                        type: TextInputType.visiblePassword,
                        label: 'Your password',
                        preIcon: Icons.password,
                        validator: (String? value) {},
                        isVisible: false,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _enabled = !_enabled;
                            });
                          },
                          child: Text(_enabled ? 'update' : 'Edit'))
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
