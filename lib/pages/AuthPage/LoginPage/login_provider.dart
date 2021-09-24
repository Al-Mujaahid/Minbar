import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:minbar_data/pages/AuthPage/LoginPage/login_actions.dart';
import 'package:minbar_data/pages/BottomNavigation/pages/AllMosques/all_mosque_provider.dart';
import 'package:minbar_data/utils/base_provider.dart';
import 'package:minbar_data/utils/constants.dart';
import 'package:minbar_data/utils/message_alert.dart';
import 'package:provider/provider.dart';

class LoginPageProvider extends BaseProvider {

  String email = '';
  String password = '';
  bool passwordIsVisible = false;

  set setEmail(String mail) {
    email = mail;
    notifyListeners();
    backToLoaded();
  }

  set setPassword(String pass) {
    password = pass;
    notifyListeners();
    backToLoaded();
  }

  set setPasswordIsVisible(bool passIsVisile) {
    passwordIsVisible = passIsVisile;
    notifyListeners();
  }

  void login(BuildContext context) {
    if (email.isEmpty && password.isEmpty) {
      backToInFo(message: 'All fields are required');
      MessageAlert.InfoAlert(context, message: 'All fields ae required');
    } else if (email.isEmpty && password.isNotEmpty) {
      backToInFo(message: 'The email fields is required');
      MessageAlert.InfoAlert(context, message: 'The email fields is required');
    } else if (email.isNotEmpty && password.isEmpty) {
      backToInFo(message: 'The password fields is required');
      MessageAlert.InfoAlert(context, message: 'The password fields is required');
    } else {
      _login(context);
    }
  }

  void _login(BuildContext context) async {
    FocusScope.of(context).unfocus();
    setPasswordIsVisible = false;
    backToInProgress(message: "Login in progress");
    try {
      var loginDetail = {
        'email': email, 'password': password
      };
      var loginResponse = await LoginActions.login(data: loginDetail);
      // print("Login response: ${loginResponse.runtimeType}");
      if (loginResponse['status'] == true) {
        var userDataBox = await Hive.openBox(USER_DATA_BOX_KEY);
        userDataBox.put(USER_DETAIL_KEY, loginResponse['data']);
        userDataBox.put(USER_TOTAL_LARGE_MOSQUE_KEY, loginResponse['stat']['tl']);
        userDataBox.put(USER_TOTAL_SMALL_MOSQUE_KEY, loginResponse['stat']['ts']);
        userDataBox.put(USER_TOTAL_MEDIUM_MOSQUE_KEY, loginResponse['stat']['tm']);
        userDataBox.put(USER_TOTAL_MOSQUE_KEY, loginResponse['stat']['tt']);
        userDataBox.put(USER_MOSQUES_KEY, loginResponse['stat']['ttm']);
        userDataBox.put(USER_LOGGED_IN_KEY, true);
        backToSuccess(message: loginResponse['msg']);
        // await Future.delayed(Duration(seconds: 2));
        Provider.of<AllMosquesProvider>(context,listen: false).refresh();
        MessageAlert.InfoAlert(context, message: loginResponse['msg'], onClose: () {
          print('Was pressed');
          Navigator.of(context).pushReplacementNamed('/');
        });
      } else {
        backToErrorOccurred(message: loginResponse['msg']);
        MessageAlert.InfoAlert(context, message: '${loginResponse['msg']}');
      }
    } catch (error) {
      backToErrorOccurred(message: 'Error: $error');
      MessageAlert.InfoAlert(context, message: 'Error: $error');
    }
  }

  LoginPageProvider() {
    backToLoaded();
  }
}