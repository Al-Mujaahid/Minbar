import 'package:minbar_data/utils/api_helper.dart';
import 'package:minbar_data/utils/end_points.dart';

class ChangePasswordActions {
  static Future changePassword({passwordData}) async {
    return ApiHelper.makePostRequest(url: changePasswordEndpoint, data: passwordData);
  }
}