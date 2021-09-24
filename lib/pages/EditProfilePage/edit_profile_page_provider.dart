import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:minbar_data/models/user.model.dart';
import 'package:minbar_data/utils/base_provider.dart';
import 'package:minbar_data/utils/constants.dart';

class EditProfilePageProvider extends BaseProvider {

  User userData;

  set setUserData(User data) {
    userData = data;
    notifyListeners();
  }

  void updateProfile(BuildContext context) {
    _updateProfile(context);
  }
  void _updateProfile(BuildContext context) async {
    try {
      backToInProgress(message: 'Updating profile...');
      await Future.delayed(Duration(seconds: 3));
      backToLoaded();
    } catch (error) {
      backToErrorOccurred(message: '$error');
    }
  }

  void initialize() async {
    try {
      backToLoaded();
    } catch (error) {
      backToErrorOccurred(message: 'Error $error');
    }
  }

  EditProfilePageProvider({User user}) {
    setUserData = user;
    initialize();
  }


}