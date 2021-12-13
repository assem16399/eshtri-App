import 'package:eshtri/models/single_product/single_product_model.dart';
import 'package:eshtri/models/single_product/single_product_model_states.dart';
import 'package:eshtri/modules/home/cubit/home_cubit.dart';
import 'package:eshtri/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesTab extends StatelessWidget {
  const FavoritesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final products = BlocProvider.of<HomeCubit>(context, listen: true).favProducts;
    return products.isEmpty
        ? Center(
            child: Text(
              'Start Adding Some Favorite Products Now 💓',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline3!.copyWith(color: kPrimarySwatchColor),
            ),
          )
        : ListView.separated(
            separatorBuilder: (_, __) => const Divider(),
            itemCount: products.length,
            itemBuilder: (_, index) => BlocProvider.value(
              value: products[index],
              child: FavoriteProductsListItem(
                id: products[index].id,
              ),
            ),
          );
  }
}

class FavoriteProductsListItem extends StatelessWidget {
  const FavoriteProductsListItem({
    required this.id,
    Key? key,
  }) : super(key: key);
  final int id;
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final product = BlocProvider.of<HomeCubit>(context).findProductById(id);
    return InkWell(
      onTap: () {},
      child: ListTile(
        minLeadingWidth: deviceSize.width * 0.2,
        title: Text(product.name),
        leading: SizedBox(
          width: deviceSize.width * 0.2,
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.contain,
          ),
        ),
        trailing: IconButton(
          onPressed: () async {
            await BlocProvider.of<SingleProductModel>(context).toggleFavoriteStates();
            BlocProvider.of<HomeCubit>(context).refreshFavoriteList();
          },
          icon: BlocConsumer<SingleProductModel, SingleProductModelStates>(
            listener: (context, singleProductState) {},
            builder: (context, singleProductState) => Icon(
              product.inFavorites ? Icons.favorite_outlined : Icons.favorite_border_outlined,
              color: Colors.deepOrange,
            ),
          ),
        ),
      ),
    );
  }
}
