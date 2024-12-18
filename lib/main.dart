import 'package:business_manager/core/main_utils/app_routes/app_routes.dart';
import 'package:business_manager/core/main_utils/bloc_provider/bloc_provider.dart';
import 'package:business_manager/core/storage_hive/hive_register_adapter.dart';
import 'package:business_manager/core/theme/app_theme.dart';
import 'package:business_manager/home_page.dart';
import 'package:business_manager/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'core/tools/flutter_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'assets/.env');
  tz.initializeTimeZones();

  await HiveRegisterAdapter.register();

  await Firebase.initializeApp();

  Bloc.observer = AppBlocObserver();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.black87,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return
        // AppRepositories(
        //   child:
        AppBlocProviders(
      child: MaterialApp(
        navigatorKey: navigatorKey,
        initialRoute: '/home_page',
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: getSupportedLocales(),
        theme: getAppTheme(),
        locale: const Locale('en'),
        routes: AppRoutes.routes,
        home: const Scaffold(
          body: Center(child: HomePage(title: "title")),
        ),
      ),
      //)
    );
  }
}
