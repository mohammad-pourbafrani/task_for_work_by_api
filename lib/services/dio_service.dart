import 'package:dio/dio.dart';

class DioService {
  Future<dynamic> getMethod(String url, Map<String, dynamic> parametr) async {
    Dio dio = Dio();

    return await dio
        .get(
      url,
      queryParameters: parametr,
      options: Options(
          contentType: "application/json",
          responseType: ResponseType.json,
          method: "GET"),
    )
        .then((response) {
      return response;
    });
  }

  Future<Response> postMethod(String url, Map<String, dynamic> userData) async {
    Dio dio = Dio();

    try {
      var response = await dio.post(
        url,
        data: userData,
        options: Options(
            contentType: "application/json",
            method: "POST",
            responseType: ResponseType.json),
      );
      return response;
    } on DioError catch (e) {
      return e.response!;
    }
  }

  Future<dynamic> postLogIn(String url, Map<String, dynamic> userData) async {
    Dio dio = Dio();

    try {
      FormData formData = FormData.fromMap(userData);
      var response = await dio.post(
        url,
        data: formData,
        options: Options(
            headers: {"Content-Type": "multipart/form-data"},
            contentType: "application/json",
            method: "POST",
            responseType: ResponseType.json),
      );
      print(response.toString());
      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future<dynamic> postUserInfo(String url, String token) async {
    Dio dio = Dio();
    dio.options.headers['authorization'] = token;
    try {
      var response = await dio.post(
        url,
        options: Options(
            // headers: {'authorization': token, "accept": "application/json"},
            contentType: "application/json",
            method: "POST",
            responseType: ResponseType.json),
      );
      return response;
    } on DioError catch (e) {
      return e.response!;
    }
  }
}
