import 'package:flutter/material.dart';
import 'package:geolocation/geolocation.dart';
import 'package:minbar_data/pages/BottomNavigation/bottom_navigation_provider.dart';
import 'package:minbar_data/pages/BottomNavigation/pages/AllMosques/all_mosque_provider.dart';
import 'package:minbar_data/utils/constants.dart';
import 'package:minbar_data/utils/routes.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var hivePath = await path.getApplicationDocumentsDirectory();
  Hive.init(hivePath.path);
  await Hive.openBox(USER_DATA_BOX_KEY);

  final GeolocationResult result = await Geolocation.requestLocationPermission(
    permission: const LocationPermission(
      android: LocationPermissionAndroid.fine,
      ios: LocationPermissionIOS.always,
    ),
    openSettingsIfDenied: true,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BottomNavigationProvider()),
        ChangeNotifierProvider(create: (context) => AllMosquesProvider()),
      ],
      child: MinbarDataApp(),
    )
  );
}

class MinbarDataApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minbar Data',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/splash',
      onGenerateRoute: (settings) => RouteGenerator.onGenerateRoute(settings),
      debugShowCheckedModeBanner: false,
    );
  }
}