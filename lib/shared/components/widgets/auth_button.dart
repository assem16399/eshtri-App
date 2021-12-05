import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final void Function() onPressed;
  final String title;
  const AuthButton({
    Key? key,
    required this.onPressed,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(title),
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(
          const Size(double.infinity, 50),
        ),
      ),
    );
  }
}
