import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../repository/repository.dart';
import '../../services/services.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
     if (event is LoginViewModel) {
        if (event.username.isEmpty || event.password.isEmpty) {
          emit(LoginError());
        } else {
          emit(LoginLoading());
          try {
            var user = await AuthRepository.instance.login(
              event.username,
              event.password,
            );

            if (user) {
              Prefs.setUsername(event.remember ? event.username : null);
              // await DashboardRepository.instance.getHeatmapColor();
              emit(LoginLoaded(user.toString()));
            } else {
              emit(LoginError());
            }
          } on Exception catch (e) {
            emit(LoginError(message: e.toString()));
          }
        }
      }
    });
  }
}
