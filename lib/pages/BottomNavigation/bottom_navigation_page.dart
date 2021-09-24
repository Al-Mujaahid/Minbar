import 'package:flutter/material.dart';
import 'package:minbar_data/pages/BottomNavigation/bottom_navigation_bar.dart';
import 'package:minbar_data/pages/BottomNavigation/bottom_navigation_provider.dart';
import 'package:provider/provider.dart';

class BottomNavPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Consumer<BottomNavigationProvider>(
            builder: (context, value, child) {
              return WillPopScope(child: value.getCurrentPage, onWillPop: () async{
                if (value.getCurrentPageIndex == 0) {
                  return true;
                }
                value.setCurrentPageIndex = value.getCurrentPageIndex - 1;
                return false;
              });
            },
          ),
          Positioned(
            bottom: 0, right: 0, left: 0,
            child: MinarDataBottomNavigationBar()
          ),
        ],
      ),
    );
  }
}