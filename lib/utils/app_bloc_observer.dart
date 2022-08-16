import 'package:flutter_bloc/flutter_bloc.dart';

import 'utils.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (bloc is Cubit) logg.dev('bloc: $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    logg.dev('bloc: $transition');
  }
}