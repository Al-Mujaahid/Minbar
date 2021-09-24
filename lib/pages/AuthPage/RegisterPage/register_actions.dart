
import 'package:minbar_data/utils/api_helper.dart';
import 'package:minbar_data/utils/end_points.dart';

class RegisterAction {
  static Future register({email, password, fname, lname, phone_no}) async {
    var data = {
      'email': email, 'password': password, 'fname': fname, 'lname': lname, 'phone_no': phone_no
    };
    return await ApiHelper.makePostRequest(url: registerEndpoint, data: data);
  }
}