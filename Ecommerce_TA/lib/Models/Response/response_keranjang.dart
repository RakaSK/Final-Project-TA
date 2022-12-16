import 'dart:convert';

ResponseKeranjang responseKeranjangFromJson(String str) =>
    ResponseKeranjang.fromJson(json.decode(str));

String responseKeranjangToJson(ResponseKeranjang data) =>
    json.encode(data.toJson());

class ResponseKeranjang {
  ResponseKeranjang({
    required this.resp,
    required this.msg,
    required this.amount,
    required this.keranjang,
  });

  bool resp;
  String msg;
  int amount;
  List<Keranjang> keranjang;

  factory ResponseKeranjang.fromJson(Map<String, dynamic> json) =>
      ResponseKeranjang(
        resp: json["resp"],
        msg: json["msg"],
        amount: json["amount"],
        keranjang: List<Keranjang>.from(
            json["keranjang"].map((x) => Keranjang.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "resp": resp,
        "msg": msg,
        "amount": amount,
        "keranjang": List<dynamic>.from(keranjang.map((x) => x.toJson())),
      };
}

class Keranjang {
  Keranjang({
    required this.uidKeranjang,
    required this.uidKeranjangDetails,
    required this.userId,
    required this.receipt,
    required this.createdAt,
    required this.amount,
    required this.nameProduct,
    required this.picture,
    required this.price,
    required this.priceawal,
    required this.quantity,
    // required this.users,
    // required this.email,
    // required this.status,
  });

  int uidKeranjang;
  int uidKeranjangDetails;
  int userId;
  String receipt;
  DateTime createdAt;
  int amount;
  String nameProduct;
  String picture;
  int price;
  int priceawal;
  int quantity;
  // String users;
  // String email;
  // String status;

  factory Keranjang.fromJson(Map<String, dynamic> json) => Keranjang(
        uidKeranjang: json["uidKeranjang"],
        uidKeranjangDetails: json["uidKeranjangDetails"],
        userId: json["user_id"],
        receipt: json["receipt"],
        createdAt: DateTime.parse(json["created_at"]),
        amount: json["amount"],
        nameProduct: json["nameProduct"],
        picture: json["picture"],
        price: json["price"],
        priceawal: json["priceawal"],
        quantity: json["quantity"],
        // users: json["users"],
        // email: json["email"],
        // status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "uidKeranjang": uidKeranjang,
        "user_id": userId,
        "receipt": receipt,
        "created_at": createdAt,
        "amount": amount,
        "nameProduct": nameProduct,
        "picture": picture,
        "price": price,
        "quantity": quantity,
        // "users": users,
        // "email": email,
        // "status": status,
      };
}
