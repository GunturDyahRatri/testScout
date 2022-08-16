import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:testscout/models/profile.dart';

import '../../repository/repository.dart';
import '../../utils/base_interceptor.dart';

part 'home_bloc_event.dart';
part 'home_bloc_state.dart';

class HomeBlocBloc extends Bloc<HomeBlocEvent, HomeBlocState> {
  HomeBlocBloc() : super(HomeBlocInitial()) {
    on<HomeBlocEvent>((event, emit) async {
      if (event is HomeBlocViewModel) {
        emit(HomeBlocLoading());
        try {
          var profile = await AuthRepository.instance.getUserInfo();

          emit(HomeBlocLoaded(profile!));
        } on UnauthorizedException catch (e) {
          emit(HomeBlocError(message: e.toString()));
        } on Exception catch (e) {
          emit(HomeBlocError(message: e.toString()));
        }
      }
    });
  }
}
