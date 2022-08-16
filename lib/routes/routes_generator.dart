import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testscout/bloc/bloc/home_bloc_bloc.dart';
import 'package:testscout/bloc/bloc/login_bloc.dart';
import 'package:testscout/pages/home_page.dart';
import 'package:testscout/pages/login_page.dart';
import 'package:testscout/pages/splash_screen.dart';
import 'package:testscout/services/prefs.dart';

part 'routes_action.dart';
part 'routes_constant.dart';

class RouteGenerator {
  final LoginBloc _loginBloc = LoginBloc();
  final HomeBlocBloc _overviewBloc = HomeBlocBloc();

  Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments as Map<String, dynamic>?;
    final isStared = Prefs.isStarted;
    final isLoggedIn = Prefs.isLoggedIn;

    if (settings.name!.startsWith(Routes.routePrefixHome)) {
      return MaterialPageRoute<dynamic>(
        builder: (context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<HomeBlocBloc>.value(value: _overviewBloc),
            ],
            child: const HomePage(
              setupPageRoute: Routes.routeHomeApproval,
            ),
          );
        },
        settings: settings,
      );
    }

    switch (settings.name) {
      case Routes.root:
        return MaterialPageRoute(
          builder: (_) => isStared
              ? (isLoggedIn
                  ? BlocProvider<HomeBlocBloc>.value(
                      value: _overviewBloc,
                      child: const HomePage(
                        setupPageRoute: Routes.routeHomeApproval,
                      ),
                    )
                  : BlocProvider<LoginBloc>.value(
                      value: _loginBloc,
                      child: const LoginPage(),
                    ))
              : const SplashScreen(),
        );
      case Routes.login:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<LoginBloc>.value(
            value: _loginBloc,
            child: const LoginPage(),
          ),
        );
    

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
