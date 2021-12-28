import 'package:eshtri/models/single_product/single_product_model.dart';
import 'package:eshtri/models/single_product/single_product_model_states.dart';
import 'package:eshtri/modules/favorites/cubit/favorites_cubit.dart';
import 'package:eshtri/modules/favorites/cubit/favorites_states.dart';
import 'package:eshtri/modules/home/cubit/home_cubit.dart';
import 'package:eshtri/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesTab extends StatefulWidget {
  const FavoritesTab({Key? key}) : super(key: key);

  @override
  State<FavoritesTab> createState() => _FavoritesTabState();
}

class _FavoritesTabState extends State<FavoritesTab> {
  @override
  void initState() {
    // TODO: implement initState

    BlocProvider.of<FavoritesCubit>(context).getFavoriteProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoritesCubit, FavoritesStates>(
        listener: (context, favoritesState) {},
        builder: (context, favoritesState) {
          final products = BlocProvider.of<FavoritesCubit>(context).favoriteProducts;
          return favoritesState is FavoritesLoadingState
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : favoritesState is FavoritesGetSuccessState
                  ? products.isEmpty
                      ? Center(
                          child: Text(
                            'Start Adding Some Favorite Products Now 💓',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(color: kPrimarySwatchColor),
                          ),
                        )
                      : ListView.separated(
                          separatorBuilder: (_, __) => const Divider(),
                          itemCount: products.length,
                          itemBuilder: (_, index) => BlocProvider.value(
                            value: products[index].singleProductModel,
                            child: FavoriteProductsListItem(
                              product: products[index].singleProductModel,
                            ),
                          ),
                        )
                  : const Center(child: Text('Something Went Wrong!'));
        });
  }
}

class FavoriteProductsListItem extends StatelessWidget {
  const FavoriteProductsListItem({
    required this.product,
    Key? key,
  }) : super(key: key);
  final SingleProductModel product;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
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
            BlocProvider.of<HomeCubit>(context).refreshHomeProductsFavoriteStatus(product.id);
            BlocProvider.of<FavoritesCubit>(context).refreshFavoriteList();
          },
          icon: BlocConsumer<SingleProductModel, SingleProductModelStates>(
            listener: (context, singleProductState) {},
            builder: (context, singleProductState) {
              return Icon(
                product.inFavorites ? Icons.favorite_outlined : Icons.favorite_border_outlined,
                color: Colors.deepOrange,
              );
            },
          ),
        ),
      ),
    );
  }
}
