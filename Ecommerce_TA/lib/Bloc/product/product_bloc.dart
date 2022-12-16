import 'package:bloc/bloc.dart';
import 'package:e_commers/Helpers/helpers.dart';
import 'package:e_commers/Models/product.dart';
import 'package:e_commers/Service/keranjang_services.dart';
import 'package:e_commers/Service/pembayaran_services.dart';
import 'package:e_commers/Service/product_services.dart';
import 'package:e_commers/ui/Views/Home/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  List<ProductCart> product = [];

  ProductBloc() : super(ProductInitial()) {
    on<OnAddOrDeleteProductFavoriteEvent>(_addOrDeleteProductFavorite);
    on<OnAddProductToCartEvent>(_addProductToCart);
    on<OnDeleteProductToCartEvent>(_deleteProductCart);
    on<OnPlusQuantityProductEvent>(_plusQuantityProduct);
    on<OnSubtractQuantityProductEvent>(_subtractQuantityProduct);
    on<OnClearProductsEvent>(_clearProduct);
    on<OnSaveProductsBuyToDatabaseEvent>(_saveProductToDatabase);
    on<OnSaveProductsBuyToDatabase2Event>(_saveProductToDatabase2);
    on<OnSelectPathImageProductEvent>(_selectImageForProduct);
    on<OnSelectPathImageBuktiProductEvent>(_selectImageForBuktiPembayaran);
    on<OnSaveNewProductEvent>(_addNewProduct);
    on<OnDeleteKeranjangEvent>(_deleteKeranjang);
    on<OnDeleteBuktiEvent>(_deleteBuktiBayar);
    on<OnDeleteProductEvent>(_deleteProduct);
    on<OnUpdateStatusPembayaranEvent>(_onUpdateStatusPembayaran);
  }

  Future<void> _addOrDeleteProductFavorite(
      OnAddOrDeleteProductFavoriteEvent event,
      Emitter<ProductState> emit) async {
    try {
      emit(LoadingProductState());

      final data =
          await productServices.addOrDeleteProductFavorite(event.uidProduct);

      if (data.resp) {
        emit(SuccessProductState());
      } else {
        emit(FailureProductState(data.message));
      }
    } catch (e) {
      emit(FailureProductState(e.toString()));
    }
  }

  Future<void> _addProductToCart(
      OnAddProductToCartEvent event, Emitter<ProductState> emit) async {
    final hasProduct = product.contains(event.product);

    // print('_addProductToCart');
    // print(event.product.amount);
    if (!hasProduct) {
      if (event.product.amount == 0) {
        modalWarning(event.context, 'Stock Kosong!');
      } else {
        event.product.amount = 1;
        double sum = 0;

        List<ProductCart> product1 = [event.product];

        final data = await keranjangServices.saveHistoryKeranjang(
            'Receipt', product1[0].price.toString(), product1);

        emit(SetAddProductToCartState(
            products: product, total: sum, amount: product.length));
      }
    }
  }

  Future<void> _deleteProductCart(
      OnDeleteProductToCartEvent event, Emitter<ProductState> emit) async {
    product.removeAt(event.index);

    double sum = 0;
    product.forEach((e) => sum = sum + e.price);

    emit(SetAddProductToCartState(
        products: product, total: sum, amount: product.length));
  }

  // Future<void> _plusQuantityProduct(
  //     OnPlusQuantityProductEvent event, Emitter<ProductState> emit) async {
  //   product[event.plus].amount++;

  //   double total = 0;
  //   product.forEach((e) => total = (total + (e.price * e.amount)));

  //   emit(SetAddProductToCartState(
  //       products: product, total: total, amount: product.length));
  // }

  Future<void> _plusQuantityProduct(
      OnPlusQuantityProductEvent event, Emitter<ProductState> emit) async {
    try {
      final data = await keranjangServices.changeItem(
          event.jenis, event.uidKeranjangDetails);

      if (data.resp) {
      } else {
        // emit(FailedChangeQty(data.message));
        modalWarning(event.context, data.message);
      }
    } catch (e) {
      // emit(FailedChangeQty(e.toString()));
    }

    // emit(SetAddProductToCartState(
    //     products: product, total: total, amount: product.length));
  }

  Future<void> _subtractQuantityProduct(
      OnSubtractQuantityProductEvent event, Emitter<ProductState> emit) async {
    product[event.subtract].amount--;

    double total = 0;
    product.forEach((e) => total = (total - (e.price * e.amount)));

    emit(SetAddProductToCartState(
        products: product, total: total.abs(), amount: product.length));
  }

  Future<void> _clearProduct(
      OnClearProductsEvent event, Emitter<ProductState> emit) async {
    product.clear();
    emit(ProductInitial());
  }

  // Future<void> _saveProductToDatabase(OnSaveProductsBuyToDatabaseEvent event,
  //     Emitter<ProductState> emit) async {
  //   try {
  //     emit(LoadingProductState());

  //     final data = await pembayaranServices.saveOrderBuyProductToDatabase(
  //         'Receipt', event.amount, event.product);

  //     if (data.resp) {
  //       emit(SuccessProductState());
  //     } else {
  //       emit(FailureProductState(data.message));
  //     }
  //   } catch (e) {
  //     emit(FailureProductState(e.toString()));
  //   }
  // }

  Future<void> _saveProductToDatabase(OnSaveProductsBuyToDatabaseEvent event,
      Emitter<ProductState> emit) async {
    try {
      emit(LoadingProductState());

      final data = await pembayaranServices.saveOrderBuyProductToDatabase1(
          event.total,
          event.ongkir,
          event.kota,
          event.estimasi,
          event.layanankirim,
          event.namakurir);

      if (data.resp) {
        emit(SuccessProductState());
      } else {
        emit(FailureProductState(data.message));
      }
    } catch (e) {
      emit(FailureProductState(e.toString()));
    }
  }

  Future<void> _selectImageForProduct(
      OnSelectPathImageProductEvent event, Emitter<ProductState> emit) async {
    emit(SetImageForProductState(event.image));
  }

  Future<void> _saveProductToDatabase2(OnSaveProductsBuyToDatabase2Event event,
      Emitter<ProductState> emit) async {
    try {
      emit(LoadingProductState());

      final data = await pembayaranServices.saveOrderBuyProductToDatabase2(
          event.uidOrder, event.image);

      if (data.resp) {
        emit(SuccessProductState());
      } else {
        emit(FailureProductState(data.message));
      }
    } catch (e) {
      emit(FailureProductState(e.toString()));
    }
  }

  Future<void> _selectImageForBuktiPembayaran(
      OnSelectPathImageBuktiProductEvent event,
      Emitter<ProductState> emit) async {
    emit(SetImageForBuktiPembayaran(event.image));
  }

  Future<void> _addNewProduct(
      OnSaveNewProductEvent event, Emitter<ProductState> emit) async {
    try {
      emit(LoadingProductState());

      final data = await productServices.addNewProduct(
          event.name,
          event.description,
          event.stock,
          event.price,
          event.uidCategory,
          event.image);

      if (data.resp) {
        emit(SuccessProductState());
      } else {
        emit(FailureProductState(data.message));
      }
    } catch (e) {
      emit(FailureProductState(e.toString()));
    }
  }

  Future<void> _deleteKeranjang(
      OnDeleteKeranjangEvent event, Emitter<ProductState> emit) async {
    try {
      // emit(LoadingProductState());

      final data = await keranjangServices
          .deleteHistoryKeranjang(event.uidKeranjangDetails);

      await Future.delayed(Duration(seconds: 1));

      if (data.resp) {
        emit(SuccessProductState());
      } else {
        emit(FailureProductState(data.message));
      }
    } catch (e) {
      emit(FailureProductState(e.toString()));
    }
  }

  Future<void> _deleteBuktiBayar(
      OnDeleteBuktiEvent event, Emitter<ProductState> emit) async {
    try {
      emit(LoadingProductState());

      final data = await pembayaranServices.deleteBuktiBayar(
          event.uidOrder, event.image);

      await Future.delayed(Duration(seconds: 1));

      if (data.resp) {
        emit(SuccessProductState());
      } else {
        emit(FailureProductState(data.message));
      }
    } catch (e) {
      emit(FailureProductState(e.toString()));
    }
  }

  Future<void> _deleteProduct(
      OnDeleteProductEvent event, Emitter<ProductState> emit) async {
    try {
      emit(LoadingProductState());

      final data = await productServices.deleteProduct(event.uidProduct);

      await Future.delayed(Duration(seconds: 1));

      if (data.resp) {
        emit(SuccessProductState());
      } else {
        emit(FailureProductState(data.message));
      }
    } catch (e) {
      emit(FailureProductState(e.toString()));
    }
  }

  Future<void> _onUpdateStatusPembayaran(
      OnUpdateStatusPembayaranEvent event, Emitter<ProductState> emit) async {
    try {
      emit(LoadingProductState());

      final data = await productServices.updateStatusPembayaran(
          event.uidOrderBuy, event.status);

      await Future.delayed(Duration(milliseconds: 1000));

      if (data.resp)
        emit(SuccessProductState());
      else
        emit(FailureProductState(data.message));
    } catch (e) {
      emit(FailureProductState(e.toString()));
    }
  }
}
