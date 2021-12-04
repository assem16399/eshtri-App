import 'package:flutter/material.dart';

class DefaultTextField extends StatelessWidget {
  final TextEditingController? controller;
  final bool isVisible;
  final String label;
  final IconData preIcon;
  final IconData? sufIcon;
  //final bool isSecuredText;
  final TextInputType type;
  final void Function(String? value)? onSaved;
  final String? Function(String? value)? validator;
  final void Function()? onSuffixIconTap;
  final void Function()? onTap;
  const DefaultTextField({
    Key? key,
    this.controller,
    required this.label,
    required this.preIcon,
    required this.type,
    this.onSaved,
    required this.validator,
    // this.isSecuredText = false,
    this.sufIcon = null,
    this.isVisible = false,
    this.onSuffixIconTap,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        onTap: onTap,
        keyboardType: type,
        obscureText: isVisible ? false : true,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
          label: Text(
            label,
            style: const TextStyle(color: Colors.grey),
          ),
          prefixIcon: Icon(
            preIcon,
          ),
          suffixIcon: sufIcon == null
              ? null
              : GestureDetector(onTap: onSuffixIconTap, child: Icon(sufIcon)),
        ),
        onSaved: onSaved,
        validator: validator,
      ),
    );
  }
}
