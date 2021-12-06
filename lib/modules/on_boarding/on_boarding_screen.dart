import 'package:eshtri/modules/login/login_screen.dart';
import 'package:eshtri/shared/network/local/cache_helper.dart';
import 'package:eshtri/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingData {
  final String image;
  final String screenTitle;
  final String screenBody;

  OnBoardingData({
    required this.image,
    required this.screenTitle,
    required this.screenBody,
  });
}

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  var _isLastBoardingReached = false;
  final pageViewController = PageController();
  final List<OnBoardingData> onBoardings = [
    OnBoardingData(
        image: 'assets/images/on boarding1.jpg',
        screenTitle: 'Your Shopping Mall at Your Hand',
        screenBody: 'Browse different categories and the items you love'),
    OnBoardingData(
        image: 'assets/images/on boarding1.jpg',
        screenTitle: 'On Boarding 2 Title',
        screenBody: 'On Boarding 2 Body'),
    OnBoardingData(
        image: 'assets/images/on boarding1.jpg',
        screenTitle: 'On Boarding 3 Title',
        screenBody: 'On Boarding 3 Body'),
  ];

  void skipOnBoarding(BuildContext context) async {
    await CacheHelper.setData(key: 'boarded', value: true);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                skipOnBoarding(context);
              },
              child: const Text(
                'SKIP',
                style: TextStyle(fontSize: 20),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: pageViewController,
                physics: const BouncingScrollPhysics(),
                itemCount: onBoardings.length,
                itemBuilder: (context, index) => PageViewItem(
                  data: onBoardings[index],
                ),
                onPageChanged: (currentIndex) {
                  if (currentIndex == onBoardings.length - 1) {
                    _isLastBoardingReached = true;
                  } else {
                    _isLastBoardingReached = false;
                  }
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SmoothPageIndicator(
                  controller: pageViewController,
                  count: onBoardings.length,
                  effect: const ExpandingDotsEffect(
                      dotColor: Colors.grey, activeDotColor: kPrimarySwatchColor),
                ),
                FloatingActionButton(
                  onPressed: () {
                    if (_isLastBoardingReached) {
                      skipOnBoarding(context);
                    } else {
                      pageViewController.nextPage(
                          duration: const Duration(milliseconds: 300), curve: Curves.linear);
                    }
                  },
                  child: const Icon(Icons.arrow_forward_ios),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PageViewItem extends StatelessWidget {
  final OnBoardingData data;
  const PageViewItem({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 6,
          child: Image.asset(
            data.image,
            fit: BoxFit.fitWidth,
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            data.screenTitle,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            data.screenBody,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
