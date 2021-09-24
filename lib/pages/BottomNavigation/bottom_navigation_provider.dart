import 'package:flutter/material.dart';
import 'package:minbar_data/pages/BottomNavigation/pages/AllMosques/all_mosques.dart';
import 'package:minbar_data/pages/BottomNavigation/pages/DashboardPage/dashboard.dart';
import 'package:minbar_data/pages/BottomNavigation/pages/ProfilePage/profile_page.dart';
import 'package:minbar_data/utils/base_provider.dart';

class BottomNavigationProvider extends BaseProvider {
  int _currentPageIndex = 0;

  List<Widget> _pages = [
    DashBoardPage(),
    AllMosques(),
    ProfilePage(),
  ];
  List<MinbarDataBottomNavItem> _bottomNavItems = [
    MinbarDataBottomNavItem(label: 'Dashboard', image: 'dashboard'),
    MinbarDataBottomNavItem(label: 'Mosques', image: 'mosque'),
    MinbarDataBottomNavItem(label: 'Profile', image: 'account'),
  ];

  set setCurrentPageIndex(int pageIndex) {
    _currentPageIndex = pageIndex;
    notifyListeners();
  }

  Widget get getCurrentPage => _pages[_currentPageIndex];
  int get getCurrentPageIndex => _currentPageIndex;
  List<MinbarDataBottomNavItem> get getNavBarItems => _bottomNavItems;


}

class MinbarDataBottomNavItem {
  String label;
  String image;

  MinbarDataBottomNavItem({this.label, this.image});
}