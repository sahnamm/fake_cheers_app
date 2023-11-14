import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class LuckyPersonProvider {
  final _dio = Dio();

  Future<Response> getLuckyPerson(int id) async {
    Response response = await _dio.get('https://reqres.in/api/users/$id');
    debugPrint(response.data.toString());
    return response;
  }
}
