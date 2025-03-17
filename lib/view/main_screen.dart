import 'package:cozy_house_app/view/core/themes/fonts.dart';
import 'package:flutter/material.dart';

import 'core/themes/colors.dart';
import 'favourite_screen.dart';
import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  late PageController _pageViewController;
  late TabController _tabController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();

    _pageViewController = PageController();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
    _tabController.dispose();
  }

  void _handlePageViewChanged(int currentPageIndex) {
    _tabController.index = currentPageIndex;
    setState(() {
      _currentPageIndex = currentPageIndex;
    });
  }

  void _updateCurrentPageIndex(int index) {
    _tabController.index = index;
    _pageViewController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget bottomNavigationBar() {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: const EdgeInsets.only(left: 24, right: 24, bottom: 30),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(23),
            child: BottomNavigationBar(
              currentIndex: _currentPageIndex,
              onTap: (value) => _updateCurrentPageIndex(value),
              selectedItemColor: blackColor,
              backgroundColor: cardBackgroundColor,
              selectedLabelStyle: blackTextStyle,
              items: [
                BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/icon_home.png",
                    width: 26,
                    height: 26,
                    color: greyColor,
                  ),
                  activeIcon: Image.asset(
                    "assets/icon_home.png",
                    width: 26,
                    height: 26,
                    color: purpleColor,
                  ),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/icon_love.png",
                    width: 26,
                    height: 26,
                    color: greyColor,
                  ),
                  activeIcon: Image.asset(
                    "assets/icon_love.png",
                    width: 26,
                    height: 26,
                    color: purpleColor,
                  ),
                  label: "Favourite",
                )
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: whiteColor,
      body: Stack(
        children: [
          PageView(
            controller: _pageViewController,
            onPageChanged: _handlePageViewChanged,
            children: [
              HomeScreen(),
              FavouriteScreen(),
            ],
          ),
          bottomNavigationBar(),
        ],
      ),
    );
  }
}
