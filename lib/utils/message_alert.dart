import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minbar_data/utils/base_provider.dart';

class MessageAlert extends BaseProvider{

  static InfoAlert(BuildContext context, {title, message, Function onClose}) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Info'),
          content: Text('$message'),
          actions: <Widget>[
            FlatButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
                if (onClose != null) {
                  print("OnClose is not null");
                  onClose();
                }
                // Dismiss alert dialog
              },
            ),
          ],
        );
      },
    );
  }


  static ConfirmAlert(BuildContext context, {message, Function onOkayPressed, String okText = 'Okay'}) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Confirm'),
          content: Text('$message'),
          actions: <Widget>[
            FlatButton(
              child: Text('cancel', style: TextStyle(
                  color: Colors.red
              ),),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog
              },
            ),
            FlatButton(
              child: Text('$okText'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
                if (onOkayPressed != null) {
                  onOkayPressed();
                }
                // Dismiss alert dialog
              },
            ),

          ],
        );
      },
    );
  }


}