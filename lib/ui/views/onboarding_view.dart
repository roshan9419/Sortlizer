import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:sorting_visualization/app/locator.dart';
import 'package:sorting_visualization/app/router.gr.dart';
import 'package:sorting_visualization/services/shared_preference_service.dart';

import '../ui_theme.dart';

class OnBoardingView extends StatefulWidget {
  @override
  _OnBoardingViewState createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  int _pageIndex = 0;
  final _sharedPrefService = locator<SharedPreferenceService>();

  onBtnTap() {
    _sharedPrefService.homeVisible = true;
    Navigator.pushReplacementNamed(context, Routes.homeView);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      decoration: BoxDecoration(
          gradient: darkGradient),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Image.asset('assets/images/logo_with_name.png', width: 100),
                Spacer(),
                GestureDetector(
                  onTap: onBtnTap,
                  child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: _pageIndex != 4
                              ? Colors.transparent
                              : Theme.of(context).primaryColor),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            _pageIndex != 4 ? 'Skip' : 'Start',
                            style: Theme.of(context).textTheme.subtitle2.copyWith(
                                color: _pageIndex != 4
                                    ? Colors.white38
                                    : Colors.white),
                          ),
                          if (_pageIndex == 4) SizedBox(width: 5),
                          if (_pageIndex == 4)
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 15,
                            )
                        ],
                      )),
                )
              ],
            ),
          ),
          SizedBox(height: 30),
          Expanded(
            child: IntroductionScreen(
              globalBackgroundColor: Colors.transparent,
              pages: [
                PageViewModel(
                    title: 'Visualize',
                    body:
                        'Easily visualize and compare different sorting algorithms',
                    decoration: _pageDecoration(context),
                    image: buildImage(
                      'assets/images/onboard/onboard_visualize.png',
                    )),
                PageViewModel(
                    title: 'Custom Input Array',
                    body: 'Visualize your custom input array of any size with any algorithm',
                    decoration: _pageDecoration(context),
                    image: buildImage(
                      'assets/images/onboard/onboard_custom.png',
                    )),
                PageViewModel(
                    title: 'Easily Compare',
                    body:
                        'Compare different sorting algorithms in real-time on parameters like size, total comparisons, & time taken',
                    decoration: _pageDecoration(context, imagePadding: 30),
                    image: buildImage(
                      'assets/images/onboard/onboard_compare.png',
                    )),
                PageViewModel(
                    title: 'Code',
                    body:
                        'Know more about the algorithm, its complexities, & code to understand its functionality & working',
                    decoration: _pageDecoration(context, imagePadding: 25),
                    image: buildImage(
                      'assets/images/onboard/onboard_code.png',
                    )),
                PageViewModel(
                    title: 'Sorting Steps',
                    body: 'Visualize how the sorted array is formed on every sorting step',
                    decoration: _pageDecoration(context, imagePadding: 25),
                    image: buildImage(
                      'assets/images/onboard/onboard_stepbystep.png',
                    )),
              ],
              done: SizedBox(width: 5),
              onDone: () {},
              onChange: (index) {
                setState(() {
                  _pageIndex = index;
                });
              },
              dotsDecorator: _dotsDecorator(),
              showNextButton: false,
              showSkipButton: false,
            ),
          ),
        ],
      ),
    ));
  }

  Widget buildImage(String path) {
    return Center(child: Image.asset(path));
  }

  PageDecoration _pageDecoration(BuildContext context, {double imagePadding = 60}) => PageDecoration(
        titleTextStyle: Theme.of(context)
            .textTheme
            .headline5
            .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        bodyTextStyle: Theme.of(context).textTheme.subtitle2.copyWith(
            color: Colors.white70,
            letterSpacing: 0.5,
            fontFamily: 'Arial',
            fontSize: 14.0),
        imagePadding: EdgeInsets.all(imagePadding),
        titlePadding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
        descriptionPadding: EdgeInsets.only(left: 40, right: 40),
      );

  DotsDecorator _dotsDecorator() => DotsDecorator(
      size: Size(8, 8),
      activeSize: Size(15, 8),
      activeShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)));
}
