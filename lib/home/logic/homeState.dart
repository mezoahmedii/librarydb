part of 'homeCubit.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}
final class HomeSuccess extends HomeState {}
final class HomeError extends HomeState {}
final class HomeLoading extends HomeState {}
