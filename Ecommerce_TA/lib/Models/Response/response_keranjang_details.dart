import 'dart:convert';

ResponseKeranjangDetails responseKeranjangDetailsFromJson(String str) =>
    ResponseKeranjangDetails.fromJson(json.decode(str));

String responseKeranjangDetailsToJson(ResponseKeranjangDetails data) =>
    json.encode(data.toJson());

class ResponseKeranjangDetails {
  ResponseKeranjangDetails({
    required this.resp,
    required this.msg,
    required this.keranjangdetails,
  });

  bool resp;
  String msg;
  List<KeranjangDetails> keranjangdetails;

  factory ResponseKeranjangDetails.fromJson(Map<String, dynamic> json) =>
      ResponseKeranjangDetails(
        resp: json["resp"],
        msg: json["msg"],
        keranjangdetails: List<KeranjangDetails>.from(
            json["keranjangdetails"].map((x) => KeranjangDetails.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "resp": resp,
        "msg": msg,
        "keranjangdetails":
            List<dynamic>.from(keranjangdetails.map((x) => x.toJson())),
      };
}

class KeranjangDetails {
  KeranjangDetails({
    required this.uidKeranjangDetails,
    required this.productId,
    required this.nameProduct,
    required this.picture,
    required this.quantity,
    required this.price,
  });

  int uidKeranjangDetails;
  int productId;
  String nameProduct;
  String picture;
  int quantity;
  int price;

  factory KeranjangDetails.fromJson(Map<String, dynamic> json) =>
      KeranjangDetails(
        uidKeranjangDetails: json["uidKeranjangDetails"],
        productId: json["product_id"],
        nameProduct: json["nameProduct"],
        picture: json["picture"],
        quantity: json["quantity"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "uidKeranjangDetails": uidKeranjangDetails,
        "product_id": productId,
        "nameProduct": nameProduct,
        "picture": picture,
        "quantity": quantity,
        "price": price,
      };
}
