import 'package:eshtri/models/categories_model.dart';
import 'package:flutter/material.dart';

import 'home_category_item.dart';

class HomeCategoriesList extends StatelessWidget {
  const HomeCategoriesList({Key? key, required this.data}) : super(key: key);

  final CategoriesData data;
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return ListView.separated(
      separatorBuilder: (context, index) => SizedBox(
        width: deviceSize.width * 0.01,
      ),
      itemCount: data.categories.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) => HomeCategoryItem(
        id: data.categories[index].id,
        title: data.categories[index].name,
        image: data.categories[index].imageUrl,
      ),
    );
  }
}
