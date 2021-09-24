import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minbar_data/pages/AddMosquePage/add_mosque_page.dart';
import 'package:minbar_data/pages/AddMosquePage/add_mosque_provider.dart';
import 'package:minbar_data/pages/AuthPage/ForgetPasswordPage/forget_password.dart';
import 'package:minbar_data/pages/AuthPage/ForgetPasswordPage/forget_password_provider.dart';
import 'package:minbar_data/pages/AuthPage/LoginPage/login_page.dart';
import 'package:minbar_data/pages/AuthPage/LoginPage/login_provider.dart';
import 'package:minbar_data/pages/AuthPage/RegisterPage/register_page.dart';
import 'package:minbar_data/pages/AuthPage/RegisterPage/register_provider.dart';
import 'package:minbar_data/pages/BottomNavigation/bottom_navigation_page.dart';
import 'package:minbar_data/pages/ChangePasswordPage/change_password_page.dart';
import 'package:minbar_data/pages/ChangePasswordPage/change_password_provider.dart';
import 'package:minbar_data/pages/EditMosquePage/edit_mosque_page.dart';
import 'package:minbar_data/pages/EditMosquePage/edit_mosque_provider.dart';
import 'package:minbar_data/pages/EditProfilePage/edit_profile_page.dart';
import 'package:minbar_data/pages/EditProfilePage/edit_profile_page_provider.dart';
import 'package:minbar_data/pages/SplashScreenPage/splash_screen_page.dart';
import 'package:provider/provider.dart';

class RouteGenerator {


  static Route onGenerateRoute(RouteSettings settings) {
    String name = settings.name;

    switch (name) {
      case '/splash':
        return MaterialPageRoute(builder: (context) => SplashScreenPage());
        break;
      case '/':
        return MaterialPageRoute(builder: (context) => BottomNavPage());
        break;
      case '/edit_profile':
        return MaterialPageRoute(builder: (context) => ChangeNotifierProvider(
          create: (context) => EditProfilePageProvider(user: settings.arguments),
          child: EditProfilePage(),
        ));
        break;
      case '/change_password':
        return MaterialPageRoute(builder: (context) => ChangeNotifierProvider(
          create: (context) => ChangePasswordProvider(),
          child: ChangePasswordPage(),
        ));
        break;
      case '/forget_password':
        return MaterialPageRoute(builder: (context) => ChangeNotifierProvider(
          create: (context) => ForgetPasswordProvider(),
          child: ForgetPasswordPage(),
        ));
        break;
      case '/add_mosque':
        return MaterialPageRoute(builder: (context) => ChangeNotifierProvider(
          create: (context) => AddMosqueProvider(),
          child: AddMosquePage(),
        ));
        break;
      case '/edit_mosque':
        return MaterialPageRoute(builder: (context) => ChangeNotifierProvider(
          create: (context) => EditMosqueProvider(mosqueData: settings.arguments),
          child: EditMosquePage(),
        ));
        break;
      case '/login':
        return MaterialPageRoute(builder: (context) => ChangeNotifierProvider(
          create: (context) => LoginPageProvider(),
          child: LoginPage(),
        ));
      case '/register':
        return MaterialPageRoute(builder: (context) => ChangeNotifierProvider(
          create: (context) => RegisterPageProvider(),
          child: RegisterPage(),
        ));
        break;
      default:
        return MaterialPageRoute(builder: (context) => Container(child: Center(
          child: Text("Page Not Found", textDirection: TextDirection.ltr,),
        ),));
    }
  }
}