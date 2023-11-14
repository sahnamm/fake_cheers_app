part of 'lucky_person_bloc.dart';

sealed class LuckyPersonState {}

final class LuckyPersonInitial extends LuckyPersonState {}

final class LuckPersonFetchedInProgress extends LuckyPersonState {}

final class LuckPersonFetchedSuccess extends LuckyPersonState {
  final String name;
  LuckPersonFetchedSuccess({required this.name});
}

final class LuckPersonFetchedFailure extends LuckyPersonState {}
