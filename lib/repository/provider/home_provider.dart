import 'package:testscout/constant/string.dart' as api;

import 'package:testscout/services/api_service.dart';

class HomeProvider {
  Future<Map<String, dynamic>> getData() async {
    var response = await ApiService().dio.post(api.getData);
    return response.data;
  }

  
}