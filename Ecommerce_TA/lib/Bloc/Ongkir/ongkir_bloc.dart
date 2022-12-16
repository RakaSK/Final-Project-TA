import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'ongkir_event.dart';
part 'ongkir_state.dart';

class OngkirBloc extends Bloc<OngkirEvent, OngkirState> {
  OngkirBloc() : super(OngkirInitial()) {
    on<PilihOngkirEvent>(_showHideMenu);
    on<DeleteOngkirEvent>(deleteongkir);
  }

  Future<void> _showHideMenu(
      PilihOngkirEvent event, Emitter<OngkirState> emit) async {
    int total = int.parse(event.Ongkir) + int.parse(event.Order);
    String Kota = event.Kota;
    String Estimasi = event.Estimasi;
    String LayananKirim = event.LayananKirim;
    String NamaKurir = event.NamaKurir;

    emit(SetOngkir(
        Ongkir: event.Ongkir,
        Total: total.toString(),
        Estimasi: event.Estimasi,
        LayananKirim: event.LayananKirim,
        Kota: event.Kota,
        NamaKurir: event.NamaKurir));
  }

  Future<void> deleteongkir(
      DeleteOngkirEvent event, Emitter<OngkirState> emit) async {
    emit(OngkirInitial());
  }
}
