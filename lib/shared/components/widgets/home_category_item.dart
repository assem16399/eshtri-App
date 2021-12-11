import 'package:flutter/material.dart';

class HomeCategoryItem extends StatelessWidget {
  const HomeCategoryItem({Key? key, required this.title, required this.id, required this.image})
      : super(key: key);

  final String title;
  final String image;
  final int id;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        SizedBox(
          width: deviceSize.width * 0.30,
          height: deviceSize.height * 0.125,
          child: Image.network(
            image,
            fit: BoxFit.contain,
          ),
        ),
        Container(
          width: deviceSize.width * 0.30,
          padding: const EdgeInsets.all(4),
          color: Colors.black54,
          child: Text(
            title,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        )
      ],
    );
  }
}
