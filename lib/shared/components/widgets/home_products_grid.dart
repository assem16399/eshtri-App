import 'package:eshtri/models/single_product/single_product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'product_card_item.dart';

class HomeProductsGrid extends StatelessWidget {
  const HomeProductsGrid({Key? key, required this.products, this.isHome = true}) : super(key: key);
  final List<SingleProductModel> products;
  final bool isHome;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return GridView.builder(
      itemCount: products.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(right: 20, left: 20, bottom: 10, top: 8),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: deviceSize.width * 0.5,
          crossAxisSpacing: deviceSize.height * 0.01,
          childAspectRatio: 3 / 4.4,
          mainAxisSpacing: deviceSize.width * 0.1),
      itemBuilder: (context, index) => BlocProvider.value(
        value: products[index],
        child: ProductCardItem(
          isHome: isHome,
          id: products[index].id,
        ),
      ),
    );
  }
}
