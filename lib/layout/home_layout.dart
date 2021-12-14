import 'package:eshtri/modules/categories/categories_tab.dart';
import 'package:eshtri/modules/favorites/favorites_tab.dart';
import 'package:eshtri/modules/home/home_tab.dart';
import 'package:eshtri/modules/search/search_screen.dart';
import 'package:eshtri/modules/profile_and_more/profile_and_more_tab.dart';
import 'package:eshtri/shared/components/widgets/app_drawer.dart';
import 'package:flutter/material.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  _HomeLayoutState createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  final _tabs = [
    const HomeTab(),
    const CategoriesTab(),
    const FavoritesTab(),
    const ProfileAndMoreTab(),
  ];
  var _tabCurrentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Eshtri'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(SearchScreen.routeName);
              },
              child: const Icon(Icons.search),
            ),
          )
        ],
      ),
      body: _tabs[_tabCurrentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tabCurrentIndex,
        onTap: (index) {
          setState(
            () {
              _tabCurrentIndex = index;
            },
          );
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_rounded), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.face_rounded), label: 'Profile & More'),
        ],
      ),
    );
  }
}
