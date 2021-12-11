import 'package:eshtri/models/home_model.dart';
import 'package:flutter/material.dart';

import 'product_card_item.dart';

class HomeProductsGrid extends StatelessWidget {
  const HomeProductsGrid({Key? key, required this.productData}) : super(key: key);
  final HomeData productData;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return GridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(right: 20, left: 20, bottom: 10, top: 8),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: deviceSize.width * 0.5,
          crossAxisSpacing: deviceSize.height * 0.01,
          childAspectRatio: 3 / 4.4,
          mainAxisSpacing: deviceSize.width * 0.1),
      children: [
        ...productData.products
            .map(
              (product) => ProductCardItem(
                imageUrl: product.imageUrl,
                title: product.name,
                discount: product.discount,
                price: product.oldPrice,
                priceAfterDiscount: product.price,
              ),
            )
            .toList()
      ],
    );
  }
}
