import 'package:flutter/cupertino.dart';
import 'package:minbar_data/pages/AuthPage/ForgetPasswordPage/forget_password_actions.dart';
import 'package:minbar_data/utils/base_provider.dart';
import 'package:minbar_data/utils/message_alert.dart';

class ForgetPasswordProvider extends BaseProvider {
  String email = '';

  void requestPasswordReset(BuildContext context) {
    if (email.isEmpty) {
      backToErrorOccurred(message: 'Email field is required');
    } else {
      _requestPasswordReset(context);
    }
  }

  void _requestPasswordReset(BuildContext context) async {
    FocusScope.of(context).unfocus();
    try {
      backToLoading(message: 'Requesting password reset...');
      var requestResponse = await ForgetPasswordActions.requestPasswordReset(resetData: {'email': email});
      // print(requestResponse);
      if (requestResponse['status'] == true) {
        MessageAlert.InfoAlert(context, message: '${requestResponse['msg']}', onClose: () {
          // Navigator.of(context).pop(('dialog'));
          Navigator.pushReplacementNamed(context, '/login');
        });
        backToLoaded();
      } else {
        MessageAlert.InfoAlert(context, message: '${requestResponse['msg']}');
        backToErrorOccurred(message: '${requestResponse['msg']}');
      }
    } catch (error) {
      MessageAlert.InfoAlert(context, message: 'Error: $error');
      backToErrorOccurred(message: 'Error: $error');
    }
  }

  ForgetPasswordProvider() {
    backToLoaded();
  }
}