import 'package:eshtri/models/home_model.dart';
import 'package:flutter/material.dart';

class HomeProductsGrid extends StatelessWidget {
  const HomeProductsGrid({Key? key, required this.productData}) : super(key: key);
  final HomeData productData;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return GridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(right: 20, left: 20, bottom: 10),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          // mainAxisExtent: deviceSize.height * 0.2,
          maxCrossAxisExtent: deviceSize.width * 0.5,
          crossAxisSpacing: deviceSize.height * 0.01,
          childAspectRatio: 1.5 / 2,
          mainAxisSpacing: deviceSize.width * 0.1),
      children: [
        ...productData.products
            .map(
              (product) => ProductItem(
                imageUrl: product.imageUrl,
                title: product.name,
              ),
            )
            .toList()
      ],
    );
  }
}

class ProductItem extends StatelessWidget {
  const ProductItem({
    Key? key,
    required this.imageUrl,
    required this.title,
  }) : super(key: key);
  final String imageUrl;
  final String title;
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return InkWell(
      onTap: () {},
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      ),
      child: Card(
        elevation: 15,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        child: GridTile(
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: Image.network(imageUrl),
          ),
          footer: Container(
            color: Colors.black45,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: deviceSize.width * 0.4,
                  height: 20,
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
