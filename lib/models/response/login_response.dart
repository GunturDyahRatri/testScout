import 'package:testscout/models/profile.dart';

class LoginResponse {
  LoginResponse({
    this.status,
    this.message,
    this.token,
    this.expireAt,
    this.data,
  });

  LoginResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    token = json['token'];
    expireAt = json['expireAt'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Profile.fromJson(v));
      });
    }
  }
  num? status;
  String? message;
  String? token;
  num? expireAt;
  List<Profile>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    map['token'] = token;
    map['expireAt'] = expireAt;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
