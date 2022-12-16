part of 'ongkir_bloc.dart';

@immutable
abstract class OngkirState {}

class OngkirInitial extends OngkirState {}

class SetOngkir extends OngkirState {
  final String Ongkir;
  final String Total;
  final String Estimasi;
  final String LayananKirim;
  final String NamaKurir;
  final String Kota;

  SetOngkir(
      {required this.Ongkir,
      required this.Total,
      required this.Estimasi,
      required this.LayananKirim,
      required this.NamaKurir,
      required this.Kota})
      : super();
}
