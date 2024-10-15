import 'package:business_manager/core/main_utils/app_routes/app_routes.dart';
import 'package:business_manager/core/main_utils/bloc_provider/bloc_provider.dart';
import 'package:business_manager/core/storage_hive/firebase/firebase_configuration.dart';
import 'package:business_manager/core/storage_hive/hive_register_adapter.dart';
import 'package:business_manager/core/theme/text_styles.dart';
import 'package:business_manager/home_page.dart';
import 'package:business_manager/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timezone/data/latest.dart' as tz;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();

  await HiveRegisterAdapter.register();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = AppBlocObserver();
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
        theme: customTheme,
        // localizationsDelegates: AppLocalizations.localizationsDelegates,
        // supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('en'),
        routes: AppRoutes.routes,
        home: Scaffold(
          body: Center(child: AddDataToFirebase()
              //HomePage(title: ""),
              ),
        ),
      ),
      //)
    );
  }
}

class AddDataToFirebase extends StatelessWidget {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add JSON Data to Firebase"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _addData(),
          child: Text("Add Data"),
        ),
      ),
    );
  }

  void _addData() {
    // Define JSON data
    final data = {
      "name": "Business Manager",
      "description": "A business management app",
      "features": {
        "invoicing": true,
        "employee_management": true,
        "calendar_integration": false
      },
      "created_at": DateTime.now().toString(),
    };

    // Push the JSON data to Firebase Realtime Database
    _dbRef.child("business_manager").set(data).then((_) {
      print("Data added successfully");
    }).catchError((error) {
      print("Failed to add data: $error");
    });
  }
}
