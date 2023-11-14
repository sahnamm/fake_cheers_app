import 'package:fake_cheers_app/enum.dart';
import 'package:fake_cheers_app/util.dart';
import 'package:flutter_test/flutter_test.dart';

class MockUtil extends Util {}

void main() {
  group('Util.doCheerMeUp() on', () {
    late MockUtil util;
    late final String name;
    Mood? mood;

    setUpAll(() {
      util = MockUtil();
      name = 'test';
    });
    tearDownAll(() => mood = null);
    group('Sad Mood =>', () {
      setUpAll(() => mood = Mood.sad);
      tearDownAll(() => mood = null);

      test('age below 18 should return discourage', () {
        final yearBorn = DateTime.now().year - 5;
        String actual = util.doCheerMeUp(name, yearBorn, mood!);
        String matcher =
            "Hi $name, no worries you will meet another sadness soon hahaha";
        expect(actual, equals(matcher));
      });

      test('age between 18 - 35 should return encourage', () {
        final yearBorn = DateTime.now().year - 20;
        String actual = util.doCheerMeUp(name, yearBorn, mood!);
        String matcher = "Hi $name! We are all in same page, dont worry!";
        expect(actual, equals(matcher));
      });

      test('age above 35 should return netral', () {
        final yearBorn = DateTime.now().year - 40;
        String actual = util.doCheerMeUp(name, yearBorn, mood!);
        String matcher =
            "Hi $name, I've got nothing to say. You are way wiser than me. You got it!";
        expect(actual, equals(matcher));
      });
    });

    group('Happy Mood =>', () {
      setUpAll(() => mood = Mood.happy);
      tearDownAll(() => mood = null);

      test('age below 18 should return discourage', () {
        final yearBorn = DateTime.now().year - 5;
        String actual = util.doCheerMeUp(name, yearBorn, mood!);
        String matcher =
            "Hi $name, life is a wheel, dont full of your self >:)";
        expect(actual, equals(matcher));
      });

      test('age between 18 - 35 should return encourage', () {
        final yearBorn = DateTime.now().year - 20;
        String actual = util.doCheerMeUp(name, yearBorn, mood!);
        String matcher = "Hi $name! That's greet, I hope everthing went well!";
        expect(actual, equals(matcher));
      });

      test('age above 35 should return netral', () {
        final yearBorn = DateTime.now().year - 40;
        String actual = util.doCheerMeUp(name, yearBorn, mood!);
        String matcher =
            "Hi $name, I've got nothing to say. You are way wiser than me. You got it!";
        expect(actual, equals(matcher));
      });
    });

    group('Neutral Mood =>', () {
      setUpAll(() => mood = Mood.neutral);
      tearDownAll(() => mood = null);

      test('age below 18 should return discourage', () {
        final yearBorn = DateTime.now().year - 5;
        String actual = util.doCheerMeUp(name, yearBorn, mood!);
        String matcher =
            "Hi $name, get a life bro dont be neutral, still a lot things to do!";
        expect(actual, equals(matcher));
      });

      test('age between 18 - 35 should return encourage', () {
        final yearBorn = DateTime.now().year - 20;
        String actual = util.doCheerMeUp(name, yearBorn, mood!);
        String matcher =
            "Hi $name! You okay? I know it can be hard sometimes but keep going!";
        expect(actual, equals(matcher));
      });

      test('age above 35 should return netral', () {
        final yearBorn = DateTime.now().year - 40;
        String actual = util.doCheerMeUp(name, yearBorn, mood!);
        String matcher =
            "Hi $name, I've got nothing to say. You are way wiser than me. You got it!";
        expect(actual, equals(matcher));
      });
    });
  });
}
