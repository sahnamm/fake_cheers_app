import 'package:bloc_test/bloc_test.dart';
import 'package:fake_cheers_app/network/blocs/luckyPerson/lucky_person_bloc.dart';
import 'package:fake_cheers_app/network/repository/lucky_person_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockLuckyPersonRepository extends Mock implements LuckyPersonRepository {}

void main() {
  late LuckyPersonBloc bloc;
  late MockLuckyPersonRepository repository;

  setUp(() {
    repository = MockLuckyPersonRepository();
    bloc = LuckyPersonBloc(repository);
  });

  tearDown(() {
    bloc.close();
  });
  group('LuckyPersonFetched', () {
    blocTest(
      'should return LuckPersonFetchedSuccess',
      setUp: () {
        when(() => repository.getLuckyPerson())
            .thenAnswer((_) async => 'Rachel Howell');
      },
      build: () => bloc,
      act: (bloc) => bloc.add(LuckyPersonFetched()),
      expect: () => [
        isA<LuckPersonFetchedInProgress>(),
        isA<LuckPersonFetchedSuccess>().having(
          (s) => s.name,
          'name',
          'Rachel Howell',
        ),
      ],
    );

    blocTest(
      'should return LuckPersonFetchedFailure',
      setUp: () {
        when(() => repository.getLuckyPerson())
            .thenThrow((_) async => Exception());
      },
      build: () => bloc,
      act: (bloc) => bloc.add(LuckyPersonFetched()),
      expect: () => [
        isA<LuckPersonFetchedInProgress>(),
        isA<LuckPersonFetchedFailure>(),
      ],
    );
  });

  group('LuckyPersonReset', () {
    blocTest(
      'should return LuckyPersonInitial',
      build: () => bloc,
      act: (bloc) => bloc.add(LuckyPersonReset()),
      expect: () => [
        isA<LuckyPersonInitial>(),
      ],
    );
  });
}
