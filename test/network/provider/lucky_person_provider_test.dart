import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  late Dio dio;
  late DioAdapter dioAdapter;

  setUpAll(() {
    dio = Dio();
    dioAdapter = DioAdapter(dio: dio);
    dio.httpClientAdapter = dioAdapter;
  });
  group('LuckyPersonProvider.getLuckyPerson()', () {
    test('should return status 200', () async {
      const dummyId = 1;
      dioAdapter.onGet(
        'https://reqres.in/api/users/$dummyId',
        (request) => request.reply(200, 'ok'),
      );
      expectLater(
        dio.get('https://reqres.in/api/users/$dummyId'),
        completes,
      );
    });

    test('should return status 404', () async {
      const dummyId = 13;
      dioAdapter.onGet('https://reqres.in/api/users/$dummyId',
          (request) => request.reply(404, {}));
      expectLater(
        dio.get('https://reqres.in/api/users/$dummyId'),
        throwsA(isA<DioException>()),
      );
    });
  });
}
