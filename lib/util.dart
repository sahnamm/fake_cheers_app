import 'dart:math';

import 'package:fake_cheers_app/enum.dart';

class Util {
  int getRandomId() {
    int randomInt = Random().nextInt(15) + 1;
    return randomInt;
  }

  String doCheerMeUp(String name, int yearBorn, Mood mood) {
    String result = 'Hi $name';
    int age = DateTime.now().year - yearBorn;
    switch (mood) {
      case Mood.sad:
        if (age <= 17) {
          result += ", no worries you will meet another sadness soon hahaha";
        } else if (age <= 35) {
          result += "! We are all in same page, dont worry!";
        } else {
          result +=
              ", I've got nothing to say. You are way wiser than me. You got it!";
        }
        break;
      case Mood.happy:
        if (age <= 17) {
          result += ", life is a wheel, dont full of your self >:)";
        } else if (age <= 35) {
          result += "! That's greet, I hope everthing went well!";
        } else {
          result +=
              ", I've got nothing to say. You are way wiser than me. You got it!";
        }
        break;
      case Mood.neutral:
        if (age <= 17) {
          result +=
              ", get a life bro dont be neutral, still a lot things to do!";
        } else if (age <= 35) {
          result +=
              "! You okay? I know it can be hard sometimes but keep going!";
        } else {
          result +=
              ", I've got nothing to say. You are way wiser than me. You got it!";
        }
        break;
      default:
        result +=
            ", I've got nothing to say. You are way wiser than me. You got it!";
        break;
    }
    return result;
  }
}
