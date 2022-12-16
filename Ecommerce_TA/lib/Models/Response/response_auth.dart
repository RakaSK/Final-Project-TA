import 'dart:convert';

ResponseAuth responseAuthFromJson(String str) =>
    ResponseAuth.fromJson(json.decode(str));

String responseAuthToJson(ResponseAuth data) => json.encode(data.toJson());

class ResponseAuth {
  ResponseAuth({
    required this.resp,
    required this.message,
    required this.token,
    required this.role,
  });

  bool resp;
  String message;
  String token;
  String role;

  factory ResponseAuth.fromJson(Map<String, dynamic> json) => ResponseAuth(
        resp: json["resp"],
        message: json["message"],
        token: json["token"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "resp": resp,
        "message": message,
        "token": token,
        "role": role,
      };
}
