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
                    Expanded(
                      child: ListView.separated(
                        separatorBuilder: (_, __) => const Divider(),
                        itemCount: loadedProducts!.length,
                        itemBuilder: (context, index) => InkWell(
                          onTap: () {},
                          child: SizedBox(
                            width: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: deviceSize.width * 0.3,
                                  height: deviceSize.height * 0.18,
                                  child: Image.network(loadedProducts[index].imageUrl),
                                ),
                                SizedBox(
                                  width: deviceSize.width * 0.02,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        loadedProducts[index].name,
                                        maxLines: 3,
                                        style: Theme.of(context).textTheme.bodyText1,
                                      ),
                                      SizedBox(
                                        height: deviceSize.height * 0.02,
                                      ),
                                      Text(
                                        '${loadedProducts[index].price} EGP',
                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
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
