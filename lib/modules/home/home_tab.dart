import 'package:carousel_slider/carousel_slider.dart';
import 'package:eshtri/models/home_model.dart';
import 'package:eshtri/modules/home/cubit/home_cubit.dart';
import 'package:eshtri/modules/home/cubit/home_states.dart';
import 'package:eshtri/shared/components/widgets/home_products_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, homeState) {},
      builder: (context, homeState) {
        final homeDataModel = BlocProvider.of<HomeCubit>(context).homeModel;
        if (homeDataModel == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return HomePageContents(
            data: homeDataModel.data!,
          );
        }
      },
    );
  }
}

class HomePageContents extends StatelessWidget {
  const HomePageContents({Key? key, required this.data}) : super(key: key);
  final HomeData data;
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: CarouselSlider(
              items: [
                ...data.banners
                    .map(
                      (banner) => SizedBox(
                        width: deviceSize.width,
                        height: deviceSize.height * 0.2,
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
                  height: deviceSize.height * 0.2,
                  initialPage: 0,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(seconds: 1),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  viewportFraction: 1),
            ),
          ),
          HomeProductsGrid(productData: data)
        ],
      ),
    );
  }
}
