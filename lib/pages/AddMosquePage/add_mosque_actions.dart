import 'package:minbar_data/utils/api_helper.dart';
import 'package:minbar_data/utils/end_points.dart';

class AddMosqueActions {

  static Future getState() async {
    return await ApiHelper.makeGetRequest(url: getListOfStateEndpoint);
  }

  static Future getStateLCDA({String stateId}) async {
    return await ApiHelper.makeGetRequest(url: '$getListOfLCDAEndpoint$stateId');
  }

  static Future addMosque({mosqueData}) async {
    return await ApiHelper.makePostRequest(url: addMosqueEndpoint, data: mosqueData);
  }

  static Future updateMosque({mosqueData}) async {
    return await ApiHelper.makePostRequest(url: updateMosqueEndpoint, data: mosqueData);
  }
}