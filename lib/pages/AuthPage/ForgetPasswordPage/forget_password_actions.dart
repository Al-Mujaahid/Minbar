import 'package:minbar_data/utils/api_helper.dart';
import 'package:minbar_data/utils/base_provider.dart';
import 'package:minbar_data/utils/end_points.dart';

class ForgetPasswordActions {

  static Future requestPasswordReset({resetData}) async {
    return ApiHelper.makePostRequest(url: requestPasswordChangeEndpoint, data: resetData);
  }
}