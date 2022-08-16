part of 'routes_generator.dart';

class RouteAction {
  RouteAction._();

  static bool goToReLogin(BuildContext context, int? code, String? message) {
    if (code == 401 && message?.toLowerCase() == 'expired token') {
      Prefs.logout().then((_) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.login,
          (route) => false,
        );
      });
      return true;
    }
    return false;
  }
}
