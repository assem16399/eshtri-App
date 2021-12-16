import 'package:eshtri/models/category_products_model.dart';
import 'package:eshtri/modules/category_products/cubit/category_products_cubit.dart';
import 'package:eshtri/modules/category_products/cubit/category_products_states.dart';
import 'package:eshtri/shared/components/widgets/home_products_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryProductsScreen extends StatefulWidget {
  const CategoryProductsScreen({Key? key}) : super(key: key);

  static const routeName = '/category-products';
  @override
  State<CategoryProductsScreen> createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero).then((_) {
      final categoryId = ModalRoute.of(context)!.settings.arguments as int;
      BlocProvider.of<CategoryProductsCubit>(context).getCategoryProducts(categoryId: categoryId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<CategoryProductsCubit, CategoryProductsStates>(
          listener: (context, categoryProductsState) {},
          builder: (context, categoryProductsState) {
            final products = BlocProvider.of<CategoryProductsCubit>(context).categoryProductsModel;
            if (categoryProductsState is CategoryProductsLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return SingleChildScrollView(
              child: HomeProductsGrid(
                isHome: false,
                products: products,
              ),
            );
          }),
    );
  }
}
