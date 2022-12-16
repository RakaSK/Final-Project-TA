part of 'total_bloc.dart';

@immutable
abstract class TotalEvent {}

class PilihTotalEvent extends TotalEvent {
  final String Total;
  final String Ongkir;

  PilihTotalEvent({required this.Total, required this.Ongkir});
}

class DeleteTotalEvent extends TotalEvent {
  DeleteTotalEvent();
}
