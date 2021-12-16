import 'package:eshtri/models/single_product/single_product_model.dart';
import 'package:eshtri/models/single_product/single_product_model_states.dart';
import 'package:eshtri/modules/home/cubit/home_cubit.dart';
import 'package:eshtri/modules/search/cubit/search_cubit.dart';
import 'package:eshtri/modules/search/cubit/search_states.dart';
import 'package:eshtri/shared/components/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  static const routeName = '/search';
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: Scaffold(
        appBar: AppBar(),
        body: BlocConsumer<SearchCubit, SearchStates>(
            listener: (context, searchState) {},
            builder: (context, searchState) {
              final loadedProducts = BlocProvider.of<SearchCubit>(context).searchedProducts;
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: TextField(
                        textInputAction: TextInputAction.search,
                        controller: searchController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.search),
                          label: Text('Search For what you are looking for'),
                        ),
                        onSubmitted: (value) async {
                          if (value.isEmpty) {
                            toast(toastMsg: 'Enter Something to search for');
                          } else {
                            await BlocProvider.of<SearchCubit>(context).searchForProducts(value);
                          }
                        },
                      ),
                    ),
                    if (searchState is SearchLoadingState)
                      const Center(
                        child: LinearProgressIndicator(),
                      ),
                    if (loadedProducts!.isNotEmpty)
                      Expanded(
                        child: ListView.separated(
                          separatorBuilder: (_, __) => const Divider(),
                          itemCount: loadedProducts.length,
                          itemBuilder: (_, index) => BlocProvider.value(
                            value: loadedProducts[index],
                            child: SearchedProductListItem(
                                deviceSize: deviceSize, loadedProduct: loadedProducts[index]),
                          ),
                        ),
                      )
                  ],
                ),
              );
            }),
      ),
    );
  }
}

class SearchedProductListItem extends StatelessWidget {
  const SearchedProductListItem({
    Key? key,
    required this.deviceSize,
    required this.loadedProduct,
  }) : super(key: key);

  final Size deviceSize;
  final SingleProductModel? loadedProduct;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: SizedBox(
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: deviceSize.width * 0.3,
              height: deviceSize.height * 0.18,
              child: Image.network(loadedProduct!.imageUrl),
            ),
            SizedBox(
              width: deviceSize.width * 0.02,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    loadedProduct!.name,
                    maxLines: 3,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SizedBox(
                    height: deviceSize.height * 0.02,
                  ),
                  Text(
                    '${loadedProduct!.price} EGP',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                BlocProvider.of<SingleProductModel>(context).toggleFavoriteStates();
                BlocProvider.of<HomeCubit>(context)
                    .refreshHomeProductsFavoriteStatus(loadedProduct!.id);
              },
              child: BlocConsumer<SingleProductModel, SingleProductModelStates>(
                listener: (context, singleProductState) {},
                builder: (context, singleProductState) => Icon(
                  loadedProduct!.inFavorites
                      ? Icons.favorite_outlined
                      : Icons.favorite_border_outlined,
                  color: Colors.deepOrange,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
