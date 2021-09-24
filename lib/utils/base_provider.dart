import 'package:flutter/cupertino.dart';
import 'package:minbar_data/utils/action_state.dart';

class BaseProvider extends ChangeNotifier {

  ActionState _actionState;
  BuildContext context;

  ActionState get getActionState => _actionState;
  String get getStatusMessage => getActionState.message;

  set setActionState(ActionState actionState) {
    _actionState = actionState;
    notifyListeners();
  }

  set setBuildContext(BuildContext ctx) {
    context = ctx;
  }

  BaseProvider() {
    backToLoading(message: 'Loading...');
  }

  void backToLoading({String message}) {
    setActionState = ActionState(message: '$message', actionStatus: ActionStatus.Loading);
    notifyListeners();
  }

  void backToLoaded() {
    setActionState = ActionState(message: '', actionStatus: ActionStatus.Loaded);
    notifyListeners();
  }

  void backToErrorOccurred({String message}) {
    setActionState = ActionState(message: '$message', actionStatus: ActionStatus.Failed);
    notifyListeners();
  }

  void backToInProgress({String message}) {
    setActionState = ActionState(message: '$message', actionStatus: ActionStatus.InProgress);
    notifyListeners();
  }

  void backToSuccess({String message}) {
    setActionState = ActionState(message: '$message', actionStatus: ActionStatus.Success);
    notifyListeners();
  }

  void backToInFo({String message}) {
    setActionState = ActionState(message: '$message', actionStatus: ActionStatus.Info);
    notifyListeners();
  }

  bool isLoading() {
    // print("From Isloading Function: ${_actionState.actionStatus}");
    bool isLoading = [ActionStatus.Loading, ActionStatus.InProgress].contains(_actionState.actionStatus);
    // print("From Isloading Function: $isLoading");
    return isLoading;
  }

  bool isErrorOccurred() {
    bool errorOccurred = [ActionStatus.Failed].contains(_actionState.actionStatus);
    return errorOccurred;
  }
}