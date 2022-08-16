part of 'home_bloc_bloc.dart';

abstract class HomeBlocState extends Equatable {
  const HomeBlocState();
}

class HomeBlocInitial extends HomeBlocState {
  @override
  List<Object> get props => [];
}

class HomeBlocLoading extends HomeBlocState {
  @override
  List<Object> get props => [];
}

class HomeBlocLoaded extends HomeBlocState {
   final Profile profile;
  // final List<String> tasks;

  const HomeBlocLoaded(this.profile);

  @override
  List<Object> get props => [profile];
}

class HomeBlocError extends HomeBlocState {
  final String? message;
   final int? code;

  const HomeBlocError({this.message, this.code});

  @override
  List<Object> get props => [];
}