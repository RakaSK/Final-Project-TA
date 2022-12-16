part of 'ongkir_bloc.dart';

@immutable
abstract class OngkirEvent {}

class PilihOngkirEvent extends OngkirEvent {
  final String Ongkir;
  final String Order;
  final String Estimasi;
  final String LayananKirim;
  final String NamaKurir;
  final String Kota;

  PilihOngkirEvent(
      {required this.Ongkir,
      required this.Order,
      required this.Estimasi,
      required this.LayananKirim,
      required this.NamaKurir,
      required this.Kota});
}

class DeleteOngkirEvent extends OngkirEvent {
  DeleteOngkirEvent();
}
