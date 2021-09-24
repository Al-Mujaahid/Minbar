import 'package:flutter/material.dart';
import 'package:minbar_data/pages/BottomNavigation/bottom_navigation_provider.dart';
import 'package:provider/provider.dart';

class MinarDataBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color:Colors.black, width: .5)
        )
      ),
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Consumer<BottomNavigationProvider>(
        builder: (context, value, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ...value.getNavBarItems.map((e) {
                int _navBarItemIndex = value.getNavBarItems.indexOf(e);
                bool isActive = value.getCurrentPageIndex == _navBarItemIndex;
                return GestureDetector(
                  onTap: () => value.setCurrentPageIndex = _navBarItemIndex,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: isActive ? Colors.black : Colors.transparent, width: 2)
                      )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/icons/${e.image}.png', height: 30, width: 30,),
                        Text('${e.label}')
                      ],
                    ),
                  ),
                );
              })
            ],
          );
        },
      )
    );
  }
}