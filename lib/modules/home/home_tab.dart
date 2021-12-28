import 'package:carousel_slider/carousel_slider.dart';
import 'package:eshtri/models/home_model.dart';
import 'package:eshtri/models/single_product/single_product_model.dart';

import 'package:eshtri/modules/home/cubit/home_cubit.dart';
import 'package:eshtri/modules/home/cubit/home_states.dart';
import 'package:eshtri/shared/components/widgets/home_products_grid.dart';
import 'package:eshtri/shared/components/widgets/home_section_title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  void initState() {
    // TODO: implement initState

    BlocProvider.of<HomeCubit>(context).getHomeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, homeState) {},
      builder: (context, homeState) {
        final homeModel = BlocProvider.of<HomeCubit>(context).homeModel;
        if (homeState is HomeLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (homeState is HomeSuccessState) {
            return HomePageContents(
              banners: homeModel!.data!.banners,
              products: homeModel.data!.products,
            );
          } else {
            return Text('something went wrong!', style: Theme.of(context).textTheme.bodyText1);
          }
        }
      },
    );
  }
}

class HomePageContents extends StatelessWidget {
  const HomePageContents({Key? key, required this.products, required this.banners})
      : super(key: key);
  final List<SingleProductModel> products;
  final List<BannerModel> banners;
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: CarouselSlider(
              items: [
                ...banners
                    .map(
                      (banner) => SizedBox(
                        width: deviceSize.width,
                        height: deviceSize.height * 0.25,
                        child: Image.network(
                          banner.imageUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    )
                    .toList()
              ],
              options: CarouselOptions(
                  height: deviceSize.height * 0.25,
                  initialPage: 0,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(seconds: 1),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  viewportFraction: 1),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: HomeSectionTitleText(
              title: 'New Products',
            ),
          ),
          HomeProductsGrid(products: products),
        ],
      ),
    );
  }
}
