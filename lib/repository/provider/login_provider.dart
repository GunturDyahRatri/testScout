import 'package:dio/dio.dart';
import 'package:testscout/constant/constant.dart';
import 'package:testscout/models/request/login_request.dart';
import 'package:testscout/models/response/login_response.dart';
import 'package:testscout/services/api_service.dart';

class AuthProvider {
  Future<LoginResponse> postLogin({required LoginRequest loginRequest}) async {
    var response = await ApiService().dio.post(
          apiLogin,
          data: FormData.fromMap(loginRequest.toJson()),
        );

    return LoginResponse.fromJson(response.data);
  }

  Future<LoginResponse> getUserInfo() async {
    var response = await ApiService().dio.get(userInfo);

    return LoginResponse.fromJson(response.data);
  }
}