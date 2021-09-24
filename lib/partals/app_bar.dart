import 'package:flutter/material.dart';
import 'package:minbar_data/pages/BottomNavigation/bottom_navigation_provider.dart';
import 'package:provider/provider.dart';

class MinbarAppBar extends StatelessWidget {
  String title;
  Widget rightSide;
  MinbarAppBar({this.title, this.rightSide});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 50, 10, 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black, width: .5
          )
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('$title', style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 24, 
          ),),
          if (rightSide == null)
            ...[
              InkWell(
                onTap: () => Provider.of<BottomNavigationProvider>(context, listen: false).setCurrentPageIndex = 2,
                child: Image.asset('assets/images/icons/account.png', height: 30, width: 30,)
              )
            ],
          if (rightSide != null)
            ...[
              rightSide
            ]
        ],
      ),
    );
  }
}