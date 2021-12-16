import 'package:eshtri/modules/categories/cubit/categories_cubit.dart';
import 'package:eshtri/modules/categories/cubit/categories_states.dart';
import 'package:eshtri/modules/category_products/category_products_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesTab extends StatefulWidget {
  const CategoriesTab({Key? key}) : super(key: key);

  @override
  State<CategoriesTab> createState() => _CategoriesTabState();
}

class _CategoriesTabState extends State<CategoriesTab> {
  @override
  void initState() {
    // TODO: implement initState

    BlocProvider.of<CategoriesCubit>(context).getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return BlocConsumer<CategoriesCubit, CategoriesStates>(
        listener: (context, categoriesState) {},
        builder: (context, categoriesState) {
          final categoriesModel = BlocProvider.of<CategoriesCubit>(context).categoriesModel;
          if (categoriesState is! CategoriesLoadingState) {
            return ListView.separated(
              separatorBuilder: (context, index) => const Divider(),
              itemCount: categoriesModel!.data!.categories.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(CategoryProductsScreen.routeName,
                      arguments: categoriesModel.data!.categories[index].id);
                },
                child: ListTile(
                  minLeadingWidth: deviceSize.width * 0.25,
                  leading: SizedBox(
                    width: deviceSize.width * 0.25,
                    child: Image.network(categoriesModel.data!.categories[index].imageUrl),
                  ),
                  title: Text(
                    categoriesModel.data!.categories[index].name.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  trailing: const Icon(Icons.navigate_next_outlined),
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
