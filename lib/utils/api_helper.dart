import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiHelper {


  static Future makeGetRequest({url}) async {
    var dio = Dio();
    dio.interceptors.add(PrettyDioLogger(
      compact: true, error: true, request: true, requestBody: true, requestHeader: true,  responseBody: true, responseHeader: true
    ));
    return dio.get(url).then((value) => value.data);
  }

  static Future makePostRequest({url, data}) async {
    var dio = Dio();
    dio.interceptors.add(PrettyDioLogger(
      compact: true, error: true, request: true, requestBody: true, requestHeader: true,  responseBody: true, responseHeader: true
    ));
    return dio.post(url, data: FormData.fromMap(data)).then((value) => value.data);
  }
}