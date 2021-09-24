class ActionState {
  String message;
  ActionStatus actionStatus;

  ActionState({this.message, this.actionStatus});
}

enum ActionStatus { Loading, Loaded, InProgress, Failed, Info, Success }
