part of 'total_bloc.dart';

@immutable
abstract class TotalState {}

class TotalInitial extends TotalState {}

class SetTotal extends TotalState {
  final String Total;

  SetTotal({required this.Total}) : super();
}
