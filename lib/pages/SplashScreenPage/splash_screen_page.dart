import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:hive/hive.dart';
import 'package:minbar_data/utils/api_helper.dart';
import 'package:minbar_data/utils/constants.dart';
import 'package:minbar_data/utils/end_points.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {

  void moveToNextPage(BuildContext context) async {
    var userDataBox = await Hive.openBox(USER_DATA_BOX_KEY);
    var isLoggedIn = userDataBox.get(USER_LOGGED_IN_KEY) ?? false;
    await Future.delayed(Duration(seconds: 2));
    print("Deciding where to go");
    if (isLoggedIn) {
      var uid = userDataBox.get(USER_DETAIL_KEY)['id'];
      var userDataResponse = await ApiHelper.makeGetRequest(url: '$userdataEndpoint$uid');
      print('UserData: $userDataResponse');
      if (userDataResponse['status'] == true) {
        var userDataBox = await Hive.openBox(USER_DATA_BOX_KEY);
        userDataBox.put(USER_DETAIL_KEY, userDataResponse['data']);
        userDataBox.put(USER_TOTAL_LARGE_MOSQUE_KEY, userDataResponse['stat']['tl']);
        userDataBox.put(USER_TOTAL_SMALL_MOSQUE_KEY, userDataResponse['stat']['ts']);
        userDataBox.put(USER_TOTAL_MEDIUM_MOSQUE_KEY, userDataResponse['stat']['tm']);
        userDataBox.put(USER_TOTAL_MOSQUE_KEY, userDataResponse['stat']['tt']);
        userDataBox.put(USER_MOSQUES_KEY, userDataResponse['stat']['ttm']);
        userDataBox.put(USER_LOGGED_IN_KEY, true);
        Navigator.pushReplacementNamed(context, '/');
      } else {
        userDataBox.put(USER_LOGGED_IN_KEY, false);
        Navigator.pushReplacementNamed(context, '/login');
      }
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  void initState() {
    super.initState();
    moveToNextPage(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FadeInUp(
              preferences: AnimationPreferences(
                duration: Duration(seconds: 1)
              ),
              child: Text("Minbar Data", style: TextStyle(
                fontSize: 32, fontWeight: FontWeight.w900, height: 5
              ), textAlign: TextAlign.center,),
            ),
            SizedBox(height: 20,),
            FadeIn(
                preferences: AnimationPreferences(
                  duration: Duration(seconds: 1),
                  offset: Duration(seconds: 1)
                ),
                child: CupertinoActivityIndicator()
            )
          ],
        ),
      ),
    );
  }
}