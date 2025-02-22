import 'package:business_manager/core/main_utils/app_routes/app_routes.dart';
import 'package:business_manager/core/main_utils/bloc_provider/bloc_provider.dart';
import 'package:business_manager/core/storage_hive/hive_register_adapter.dart';
import 'package:business_manager/core/theme/app_theme.dart';
import 'package:business_manager/core/screens/home_screen.dart';
import 'package:business_manager/dependecy_injection.dart';
import 'package:business_manager/observer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'core/supabase/supabase_config.dart';
import 'core/tools/flutter_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  tz.initializeTimeZones();

  await HiveRegisterAdapter.register();

  await Supabase.initialize(
    url: SupabaseConfig.supabaseUrl,
    anonKey: SupabaseConfig.supabaseAnonKey,
  );

  Bloc.observer = AppBlocObserver();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.black87,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );

  DependencyInjection.init();
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
      child: GetMaterialApp(
        navigatorKey: navigatorKey,
        initialRoute: '/home_page',
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: getSupportedLocales(),
        theme: getAppTheme(),
        locale: const Locale('en'),
        routes: AppRoutes.routes,
        home: const HomePage(),
      ),
      //)
    );
  }
}
