import 'package:dio/dio.dart';
import 'package:fake_cheers_app/network/provider/lucky_person_provider.dart';
import 'package:fake_cheers_app/network/repository/lucky_person_repository.dart';
import 'package:fake_cheers_app/util.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockLuckyPersonProvider extends Mock implements LuckyPersonProvider {}

class MockLuckyPersonRepository extends LuckyPersonRepository {
  MockLuckyPersonRepository(super.provider, super.util);
}

class MockUtil extends Mock implements Util {}

void main() {
  late MockLuckyPersonProvider provider;
  late MockLuckyPersonRepository repository;
  late MockUtil util;

  setUpAll(() {
    provider = MockLuckyPersonProvider();
    util = MockUtil();
    repository = MockLuckyPersonRepository(provider, util);
  });
  group('LuckyPersonRepository.getLuckyPerson()', () {
    test('should return data found', () async {
      // given
      when(() => util.getRandomId()).thenAnswer((invocation) => 12);
      when(() => provider.getLuckyPerson(any())).thenAnswer(
        (_) async => Response(
          statusCode: 200,
          data: {
            "data": {
              "id": 12,
              "first_name": "Rachel",
              "last_name": "Howell",
            },
          },
          requestOptions: RequestOptions(),
        ),
      );

      final res = await repository.getLuckyPerson();
      expect(res, equals('Rachel Howell'));
    });
  });

  group('LuckyPersonRepository.getLuckyPerson()', () {
    test('should return data not found', () async {
      when(() => util.getRandomId()).thenAnswer((invocation) => 15);
      when(() => provider.getLuckyPerson(any())).thenAnswer(
        (_) async => Response(
          statusCode: 404,
          data: {},
          requestOptions: RequestOptions(),
        ),
      );
      expectLater(
        repository.getLuckyPerson(),
        throwsA(isA<Exception>()),
      );
    });
  });
}
