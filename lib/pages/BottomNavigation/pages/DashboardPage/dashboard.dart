import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:minbar_data/models/mosque.model.dart';
import 'package:minbar_data/pages/BottomNavigation/pages/AllMosques/one_mosque.dart';
import 'package:minbar_data/pages/BottomNavigation/pages/DashboardPage/statItem.dart';
import 'package:minbar_data/partals/app_bar.dart';
import 'package:minbar_data/utils/constants.dart';

class DashBoardPage extends StatelessWidget {
  double fontSize = 10;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MinbarAppBar(title: 'Dashboard',),
            WatchBoxBuilder(
              box: Hive.box(USER_DATA_BOX_KEY),
              builder: (context, box) {
                var smallMosques = box.get(USER_TOTAL_SMALL_MOSQUE_KEY);
                var mediumMosques = box.get(USER_TOTAL_MEDIUM_MOSQUE_KEY);
                return  Container(
                  margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MinbarDataStatItem(label: 'Small Mosques', value: '$smallMosques',),
                      MinbarDataStatItem(label: 'Medium Mosques', value: '$mediumMosques',),
                    ],
                  ),
                );
              },
            ),

            WatchBoxBuilder(
              box: Hive.box(USER_DATA_BOX_KEY),
              builder: (context, box) {
                var largeMosques = box.get(USER_TOTAL_LARGE_MOSQUE_KEY);
                var totalMosques = box.get(USER_TOTAL_MOSQUE_KEY);
                return  Container(
                  margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MinbarDataStatItem(label: 'large Mosques', value: '$largeMosques',),
                      MinbarDataStatItem(label: 'Total Mosques', value: '$totalMosques',),
                    ],
                  ),
                );
              },
            ),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Text('Recently added mosques', style: TextStyle(
                fontWeight: FontWeight.w500, fontSize: 16
              ),),
            ),

            WatchBoxBuilder(
              box: Hive.box(USER_DATA_BOX_KEY),
              builder: (context, box) {
                var mosques = box.get(USER_MOSQUES_KEY) ?? [];
                return  Container(
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ...mosques.reversed.take(10).toList().map((msq) {
                        // print(msq);
                        Mosque mosque = Mosque.fromJson(msq);
                        return OneMosque(mosque: mosque,);
                      })
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: 50,),
          ],
        ),
      ),
    );
  }
}