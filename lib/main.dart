import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testscout/utils/app_bloc_observer.dart';
import 'package:testscout/utils/app_info.dart';

import 'routes/routes.dart';
import 'services/prefs.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppInfo().initPackageInfo();
  await Prefs.init();
  BlocOverrides.runZoned(
    () => runApp(const MyApp()),
    blocObserver: AppBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp(
        title: 'FIRMS KALOG',
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.root,
        onGenerateRoute: RouteGenerator().generateRoute,
      ),
    );
  }
}
