part of 'login_bloc.dart';

@immutable
abstract class LoginState extends Equatable {}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoading extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoaded extends LoginState {
  final String username;

  LoginLoaded(this.username);

  @override
  List<Object> get props => [username];
}

class LoginError extends LoginState {
  final String? message;

  LoginError({this.message});

  @override
  List<Object> get props => [];
}
