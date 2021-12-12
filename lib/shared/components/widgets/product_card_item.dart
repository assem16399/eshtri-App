import 'package:eshtri/models/single_product/single_product_model.dart';
import 'package:eshtri/models/single_product/single_product_model_states.dart';
import 'package:eshtri/modules/home/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCardItem extends StatelessWidget {
  const ProductCardItem({
    Key? key,
    required this.id,
  }) : super(key: key);

  final int id;

  @override
  Widget build(BuildContext context) {
    final product = BlocProvider.of<HomeCubit>(context).findProductById(id);

    final deviceSize = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Card(
            elevation: 15,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
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
                    product.imageUrl,
                  ),
                ),
              ),
              footer: Container(
                decoration: const BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white70,
                            height: 1.1,
                            fontWeight: FontWeight.bold),
                      ),
                      if (product.discount == 0)
                        Text(
                          '${product.price} EGP',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      if (product.discount > 0)
                        Row(
                          children: [
                            Text(
                              product.oldPrice.toString(),
                              style: const TextStyle(
                                decorationStyle: TextDecorationStyle.solid,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            SizedBox(
                              width: deviceSize.width * 0.01,
                            ),
                            Text(
                              '${product.price} EGP',
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
          if (product.discount > 0)
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
                  child: Text('${product.discount} %'),
                ),
              ),
            ),
          Positioned(
            top: deviceSize.height * 0.01,
            left: deviceSize.width * 0.03,
            child: GestureDetector(
              onTap: () {
                BlocProvider.of<SingleProductModel>(context).toggleFavoriteStates();
                print(product.inFavorites);
              },
              child: BlocConsumer<SingleProductModel, SingleProductModelStates>(
                listener: (context, singleProductState) {},
                builder: (context, singleProductState) => Icon(
                  BlocProvider.of<SingleProductModel>(context).inFavorites
                      ? Icons.favorite_outlined
                      : Icons.favorite_border_outlined,
                  size: 30,
                  color: Colors.deepOrange,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
