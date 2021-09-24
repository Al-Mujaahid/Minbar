import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:minbar_data/pages/ChangePasswordPage/change_password_actions.dart';
import 'package:minbar_data/utils/base_provider.dart';
import 'package:minbar_data/utils/constants.dart';
import 'package:minbar_data/utils/message_alert.dart';

class ChangePasswordProvider extends BaseProvider {

  String oldPassword = '';
  String newPassword = '';
  String confirmNewPassword = '';
  String userId = '';
  bool passwordIsVisible = false;

  set setPasswordIsVisible(bool passIsVisible) {
    passwordIsVisible = passIsVisible;
    notifyListeners();
  }


  void updatePassword(BuildContext context) {
    if (confirmNewPassword.isEmpty || newPassword.isEmpty || oldPassword.isEmpty) {
      backToErrorOccurred(message: 'All fields are required');
      MessageAlert.InfoAlert(context, message: 'All fields are required');
    } else if (newPassword != confirmNewPassword) {
      backToErrorOccurred(message: 'New password and confirm password must match');
      MessageAlert.InfoAlert(context, message: 'New password and confirm password must match');
    } else {
      _updatePassword(context);
    }

  }
  void _updatePassword(BuildContext context) async {
    try {
      setPasswordIsVisible = false;
      backToInProgress(message: 'Changing password...');
      // await Future.delayed(Duration(seconds: 3));
      var passwordData = {
        'password': newPassword, 'old_password': oldPassword, 'id': userId
      };
      var passwordChangeResponse = await ChangePasswordActions.changePassword(passwordData: passwordData);
      if (passwordChangeResponse['status'] == true) {
        backToErrorOccurred(message: '${passwordChangeResponse['msg']}');
        MessageAlert.InfoAlert(context, message: '${passwordChangeResponse['msg']}', onClose: () {
          Navigator.of(context).pop();
        });
      } else {
        backToErrorOccurred(message: '${passwordChangeResponse['msg']}');
        MessageAlert.InfoAlert(context, message: '${passwordChangeResponse['msg']}');
      }
      print(passwordChangeResponse);
      backToLoaded();
    } catch (error) {
      backToErrorOccurred(message: '$error');
      MessageAlert.InfoAlert(context, message: 'Error: $error');
    }
  }

  void initialize() async {
    try {
      var userBox = await Hive.openBox(USER_DATA_BOX_KEY);
      userId = userBox.get(USER_DETAIL_KEY)['id'];
      backToLoaded();
    } catch (error) {
      backToErrorOccurred(message: 'Error $error');
    }
  }

  ChangePasswordProvider() {
    initialize();
  }


}