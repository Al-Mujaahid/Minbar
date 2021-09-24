import 'package:minbar_data/utils/api_helper.dart';
import 'package:minbar_data/utils/end_points.dart';

class LoginActions {

  static Future login({data}) async {
    return await ApiHelper.makePostRequest(url: loginEndpoint, data: data);
  }
  
}