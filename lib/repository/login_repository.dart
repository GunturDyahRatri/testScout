
import 'package:testscout/models/profile.dart';
import 'package:testscout/models/request/login_request.dart';
import 'package:testscout/repository/provider/login_provider.dart';
import 'package:testscout/services/services.dart';

class AuthRepository {
  AuthRepository._();

  static final AuthRepository instance = AuthRepository._();

  final authProvider = AuthProvider();

  Future<bool> login(String username, String password) async {
    final response = await authProvider.postLogin(
      loginRequest: LoginRequest(
        username: username,
        password: password,
      ),
    );
    Prefs.setToken(response.token);
    if (response.data?.isNotEmpty ?? false) {
      Prefs.setProfile(response.data![0]);
    }
    return response.token != null;
  }

  Profile profilePref() {
    return Prefs.profile;
  }

  Future<Profile?> getUserInfo() async {
    final response = await authProvider.getUserInfo();
    if (response.data?.isNotEmpty ?? false) {
      return response.data![0];
    }
    return null;
  }
}
