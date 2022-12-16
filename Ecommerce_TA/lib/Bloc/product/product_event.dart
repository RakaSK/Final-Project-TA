part of 'product_bloc.dart';

@immutable
abstract class ProductEvent {}

class OnAddOrDeleteProductFavoriteEvent extends ProductEvent {
  final String uidProduct;

  OnAddOrDeleteProductFavoriteEvent({required this.uidProduct});
}

class OnAddProductToCartEvent extends ProductEvent {
  final ProductCart product;
  final BuildContext context;

  OnAddProductToCartEvent(this.context, this.product);
}

class OnDeleteProductToCartEvent extends ProductEvent {
  final int index;

  OnDeleteProductToCartEvent(this.index);
}

// class OnPlusQuantityProductEvent extends ProductEvent {
//   final int plus;

//   OnPlusQuantityProductEvent(this.plus);
// }

class OnPlusQuantityProductEvent extends ProductEvent {
  String jenis;
  String uidKeranjangDetails;
  BuildContext context;

  OnPlusQuantityProductEvent(
      this.jenis, this.uidKeranjangDetails, this.context);
}

class OnSubtractQuantityProductEvent extends ProductEvent {
  final int subtract;

  OnSubtractQuantityProductEvent(this.subtract);
}

class OnClearProductsEvent extends ProductEvent {}

class OnSaveProductsBuyToDatabaseEvent extends ProductEvent {
  final int total;
  final int ongkir;
  final String kota;
  final String estimasi;
  final String layanankirim;
  final String namakurir;
  final String uidKeranjang;

  OnSaveProductsBuyToDatabaseEvent(this.total, this.ongkir, this.kota,
      this.estimasi, this.layanankirim, this.namakurir, this.uidKeranjang);
}

class OnSelectPathImageProductEvent extends ProductEvent {
  final String image;

  OnSelectPathImageProductEvent(this.image);
}

class OnSelectPathImageBuktiProductEvent extends ProductEvent {
  final String image;

  OnSelectPathImageBuktiProductEvent(this.image);
}

class OnSaveNewProductEvent extends ProductEvent {
  final String name;
  final String description;
  final String stock;
  final String price;
  final String uidCategory;
  final String image;

  OnSaveNewProductEvent(this.name, this.description, this.stock, this.price,
      this.uidCategory, this.image);
}

class OnSaveProductsBuyToDatabase2Event extends ProductEvent {
  final String image;
  final String uidOrder;

  OnSaveProductsBuyToDatabase2Event(this.uidOrder, this.image);
}

class OnDeleteKeranjangEvent extends ProductEvent {
  final String uidKeranjangDetails;

  OnDeleteKeranjangEvent(this.uidKeranjangDetails);
}

class OnDeleteBuktiEvent extends ProductEvent {
  final String uidOrder;
  final String image;

  OnDeleteBuktiEvent(this.uidOrder, this.image);
}

class OnDeleteProductEvent extends ProductEvent {
  final String uidProduct;

  OnDeleteProductEvent(this.uidProduct);
}

class OnUpdateStatusPembayaranEvent extends ProductEvent {
  final String uidOrderBuy;
  final String status;

  OnUpdateStatusPembayaranEvent(this.uidOrderBuy, this.status);
}
