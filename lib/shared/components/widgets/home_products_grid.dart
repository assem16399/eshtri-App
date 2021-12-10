import 'package:eshtri/models/home_model.dart';
import 'package:eshtri/shared/styles/colors.dart';
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
      padding: const EdgeInsets.only(right: 20, left: 20, bottom: 10, top: 16),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: deviceSize.width * 0.5,
          crossAxisSpacing: deviceSize.height * 0.01,
          childAspectRatio: 3 / 4.4,
          mainAxisSpacing: deviceSize.width * 0.1),
      children: [
        ...productData.products
            .map(
              (product) => ProductItem(
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

class ProductItem extends StatelessWidget {
  const ProductItem({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.discount,
    required this.price,
    required this.priceAfterDiscount,
  }) : super(key: key);
  final String imageUrl;
  final String title;
  final int discount;
  final dynamic price;
  final dynamic priceAfterDiscount;
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {},
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Card(
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
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.network(
                    imageUrl,
                  ),
                ),
              ),
              footer: Container(
                color: Colors.black54,
                width: deviceSize.width * 0.4,
                height: deviceSize.height * 0.08,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white70,
                            height: 1.1,
                            fontWeight: FontWeight.bold),
                      ),
                      if (discount == 0)
                        Text(
                          '$priceAfterDiscount EGP',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      if (discount > 0)
                        Row(
                          children: [
                            Text(
                              price.toString(),
                              style: const TextStyle(
                                decorationStyle: TextDecorationStyle.solid,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            SizedBox(
                              width: deviceSize.width * 0.01,
                            ),
                            Text(
                              '$priceAfterDiscount EGP',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        )
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (discount > 0)
            Positioned(
              right: -10,
              top: -15,
              child: Card(
                color: Colors.orange,
                elevation: 10,
                shape: const CircleBorder(),
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.transparent,
                  child: Text('$discount %'),
                ),
              ),
            ),
          Positioned(
            top: deviceSize.height * 0.01,
            left: deviceSize.width * 0.03,
            child: GestureDetector(
              onTap: () {},
              child: const Icon(
                Icons.favorite_border_outlined,
                size: 30,
                color: Colors.deepOrange,
              ),
            ),
          )
        ],
      ),
    );
  }
}
