import 'package:eshtri/models/login_model.dart';
import 'package:eshtri/modules/profile/cubit/profile_cubit.dart';
import 'package:eshtri/shared/components/toast.dart';
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
  bool? _isLoading = false;

  UserData? updatedUserData = UserData(
    id: null,
    name: '',
    email: '',
    phone: '',
    image: '',
    points: 0,
    credit: 0,
    token: '',
  );

  void submitUpdateProfileForm() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      try {
        await BlocProvider.of<ProfileCubit>(context).updateUserProfile(updatedUserData!);
        setState(() {
          _isLoading = false;
          _enabled = false;
        });
      } catch (error) {
        toast(toastMsg: error.toString());
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _isLoading = true;
    BlocProvider.of<ProfileCubit>(context).getProfileData().then((_) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }).catchError((_) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final profileModel = BlocProvider.of<ProfileCubit>(context, listen: true).profileModel;
    updatedUserData = profileModel?.data;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Profile'),
      ),
      body: _isLoading!
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        DefaultTextField(
                          enabled: _enabled,
                          initialValue: profileModel!.data!.name,
                          type: TextInputType.name,
                          label: 'Your Name',
                          preIcon: Icons.face_rounded,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please Enter your Name';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            updatedUserData = updatedUserData!.copyWith(name: value);
                          },
                        ),
                        DefaultTextField(
                          enabled: _enabled,
                          initialValue: profileModel.data!.email,
                          type: TextInputType.emailAddress,
                          label: 'Your Email',
                          preIcon: Icons.email_outlined,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please Enter your Email Address';
                            }
                            if (!value.contains('@') || !value.contains('.')) {
                              return 'Please Enter a valid Email';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            updatedUserData = updatedUserData!.copyWith(email: value);
                          },
                        ),
                        DefaultTextField(
                          enabled: _enabled,
                          initialValue: profileModel.data!.phone,
                          type: TextInputType.phone,
                          label: 'Your Phone',
                          preIcon: Icons.phone,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please Enter your Phone';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            updatedUserData = updatedUserData!.copyWith(phone: value);
                          },
                        ),
                        _isLoading!
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : ElevatedButton(
                                onPressed: () {
                                  if (_enabled) {
                                    submitUpdateProfileForm();
                                  }
                                  setState(() {
                                    _enabled = true;
                                  });
                                },
                                child: Text(_enabled ? 'update' : 'Edit'))
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
