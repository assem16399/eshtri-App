import 'package:eshtri/modules/categories/cubit/categories_cubit.dart';
import 'package:eshtri/modules/categories/cubit/categories_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesTab extends StatefulWidget {
  const CategoriesTab({Key? key}) : super(key: key);

  @override
  State<CategoriesTab> createState() => _CategoriesTabState();
}

class _CategoriesTabState extends State<CategoriesTab> {
  bool? _isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    _isLoading = true;
    BlocProvider.of<CategoriesCubit>(context).getCategories().then((_) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return BlocConsumer<CategoriesCubit, CategoriesStates>(
        listener: (context, categoriesState) {},
        builder: (context, categoriesState) {
          final categoriesModel = BlocProvider.of<CategoriesCubit>(context).categoriesModel;
          if (!_isLoading!) {
            return ListView.separated(
              separatorBuilder: (context, index) => const Divider(),
              itemCount: categoriesModel!.data!.categories.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {},
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
