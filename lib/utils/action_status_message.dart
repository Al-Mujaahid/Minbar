import 'package:flutter/material.dart';
import 'package:minbar_data/utils/action_state.dart';

class ActionStatusMessage extends StatelessWidget {
  ActionState actionState;
  ActionStatusMessage({this.actionState});

  Color textColor = Colors.black;
  Color backgroundColor = Colors.white54;


  @override
  Widget build(BuildContext context) {
    if ([ActionStatus.Failed].contains(actionState.actionStatus)) {
      textColor = Colors.white;
      backgroundColor = Colors.red.shade200;
    }
    if ([ActionStatus.Loading, ActionStatus.InProgress].contains(actionState.actionStatus)) {
      textColor = Colors.white;
      backgroundColor = Colors.blue.shade200;
    }
    if (actionState.actionStatus == ActionStatus.Success) {
      textColor = Colors.white;
      backgroundColor = Colors.green.shade200;
    }
    if ([ActionStatus.Info].contains(actionState.actionStatus)) {
      textColor = Colors.white;
      backgroundColor = Colors.orange.shade200;
    }
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(8))
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Text("${actionState.message}", style: TextStyle(
        fontSize: 15, color: textColor
      ),),
    );
  }
}