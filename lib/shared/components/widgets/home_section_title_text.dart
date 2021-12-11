import 'package:flutter/material.dart';

class HomeSectionTitleText extends StatelessWidget {
  final String title;
  const HomeSectionTitleText({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 25),
    );
  }
}
