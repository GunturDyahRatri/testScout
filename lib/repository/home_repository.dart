import 'package:testscout/repository/provider/home_provider.dart';

class HomeRepository {
  HomeRepository._();

  static final HomeRepository instance = HomeRepository._();

  final homeProvider = HomeProvider();

  Future<Map<String, dynamic>> getData() async {
    var response = await homeProvider.getData();
    return response['data'];
  }


}
