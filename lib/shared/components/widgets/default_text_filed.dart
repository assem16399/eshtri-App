import 'package:flutter/material.dart';

class DefaultTextField extends StatelessWidget {
  final String? initialValue;
  final bool enabled;
  final TextEditingController? controller;
  final bool isVisible;
  final String label;
  final IconData preIcon;
  late final IconData? sufIcon;
  final TextInputType type;
  final void Function(String? value)? onSaved;
  final String? Function(String? value)? validator;
  final String? Function(String? value)? onSubmit;
  final void Function()? onSuffixIconTap;
  final void Function()? onTap;
  DefaultTextField(
      {Key? key,
      this.initialValue,
      this.enabled = true,
      this.controller,
      required this.label,
      required this.preIcon,
      required this.type,
      this.onSaved,
      required this.validator,
      this.sufIcon,
      this.isVisible = true,
      this.onSuffixIconTap,
      this.onTap,
      this.onSubmit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        enabled: enabled,
        initialValue: initialValue,
        onFieldSubmitted: onSubmit,
        controller: controller,
        onTap: onTap,
        keyboardType: type,
        obscureText: isVisible ? false : true,
        decoration: InputDecoration(
          disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
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
