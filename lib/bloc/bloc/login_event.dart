part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginViewModel extends LoginEvent {
  LoginViewModel({
    required this.username,
    required this.password,
    this.remember = false,
  });

  final String username;
  final String password;
  final bool remember;
}
