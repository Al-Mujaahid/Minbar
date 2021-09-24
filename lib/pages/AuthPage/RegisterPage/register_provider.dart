import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:minbar_data/pages/AuthPage/LoginPage/login_actions.dart';
import 'package:minbar_data/pages/AuthPage/RegisterPage/register_actions.dart';
import 'package:minbar_data/pages/BottomNavigation/pages/AllMosques/all_mosque_provider.dart';
import 'package:minbar_data/utils/base_provider.dart';
import 'package:minbar_data/utils/constants.dart';
import 'package:minbar_data/utils/message_alert.dart';
import 'package:provider/provider.dart';

class RegisterPageProvider extends BaseProvider {

  String email = '';
  String fname = '';
  String lname = '';
  String phone = '';
  String password = '';
  bool passwordIsVisible = false;

  set setEmail(String mail) {
    email = mail;
    notifyListeners();
    backToLoaded();
  }
  set setPhone(String mail) {
    phone = mail;
    notifyListeners();
    backToLoaded();
  }

  set setLastName(String mail) {
    lname = mail;
    notifyListeners();
    backToLoaded();
  }

  set setFirstName(String mail) {
    fname = mail;
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

  void register(BuildContext context) {
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
      var loginResponse = await RegisterAction.register(
        email: email, fname: fname, lname: lname, password: password, phone_no: phone
      );
      // print("Login response: ${loginResponse.runtimeType}");
      if (loginResponse['status'] == true) {

        backToSuccess(message: loginResponse['msg']);

        MessageAlert.InfoAlert(context, message: loginResponse['msg'], onClose: () {
          print('Was pressed');
          Navigator.of(context).pushReplacementNamed('/login');
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

  RegisterPageProvider() {
    backToLoaded();
  }
}