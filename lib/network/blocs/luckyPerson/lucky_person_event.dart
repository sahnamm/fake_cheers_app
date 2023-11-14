part of 'lucky_person_bloc.dart';

sealed class LuckyPersonEvent {}

class LuckyPersonFetched extends LuckyPersonEvent {}

class LuckyPersonReset extends LuckyPersonEvent {}
