import 'package:fake_cheers_app/main.dart';
import 'package:fake_cheers_app/network/blocs/luckyPerson/lucky_person_bloc.dart';
import 'package:fake_cheers_app/network/provider/lucky_person_provider.dart';
import 'package:fake_cheers_app/network/repository/lucky_person_repository.dart';
import 'package:fake_cheers_app/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Initialization', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          Provider<LuckyPersonProvider>(
            create: (context) => LuckyPersonProvider(),
          ),
          Provider<Util>(
            create: (context) => Util(),
          ),
        ],
        child: Provider<LuckyPersonRepository>(
          create: (context) => LuckyPersonRepository(
            context.read<LuckyPersonProvider>(),
            context.read<Util>(),
          ),
          child: BlocProvider(
            create: (context) => LuckyPersonBloc(
              context.read<LuckyPersonRepository>(),
            ),
            child: const MyApp(),
          ),
        ),
      ),
    );

    expect(find.text('Name: '), findsOneWidget);
    expect(find.text('Year Born: '), findsOneWidget);
    expect(find.text('Current Mood: '), findsOneWidget);
    expect(find.text('Pick one!'), findsNothing);

    expect(find.byKey(const Key('text-field-name')), findsOneWidget);
    expect(find.byKey(const Key('text-field-year-born')), findsOneWidget);
    expect(find.byKey(const Key('bloc-builder')), findsOneWidget);
    expect(find.byKey(const Key('text-cheer-up')), findsNothing);

    expect(find.byType(CheckboxListTile), findsNWidgets(3));
    expect(find.byType(ElevatedButton), findsNWidgets(3));
  });
}
