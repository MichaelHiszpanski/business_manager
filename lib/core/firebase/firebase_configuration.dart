import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      default:
        throw UnsupportedError('DefaultFirebaseOptions are not supported for this platform.');
    }
  }

  static final FirebaseOptions web = FirebaseOptions(
    apiKey: dotenv.env['WEB_API_KEY'] ?? '',
    authDomain: dotenv.env['WEB_AUTH_DOMAIN'] ?? '',
    databaseURL: dotenv.env['WEB_DATABASE_URL'] ?? '',
    projectId: dotenv.env['WEB_PROJECT_ID'] ?? '',
    storageBucket: dotenv.env['WEB_STORAGE_BUCKET'] ?? '',
    messagingSenderId: dotenv.env['WEB_MESSAGING_SENDER_ID'] ?? '',
    appId: dotenv.env['WEB_APP_ID'] ?? '',
    measurementId: dotenv.env['WEB_MEASUREMENT_ID'] ?? '',
  );

  static final FirebaseOptions android = FirebaseOptions(
    apiKey: dotenv.env['ANDROID_API_KEY'] ?? '',
    appId: dotenv.env['ANDROID_APP_ID'] ?? '',
    messagingSenderId: dotenv.env['ANDROID_MESSAGING_SENDER_ID'] ?? '',
    projectId: dotenv.env['WEB_PROJECT_ID'] ?? '',
    storageBucket: dotenv.env['WEB_STORAGE_BUCKET'] ?? '',
    databaseURL: dotenv.env['WEB_DATABASE_URL'] ?? '',
  );

  static final FirebaseOptions ios = FirebaseOptions(
    apiKey: dotenv.env['IOS_API_KEY'] ?? '',
    appId: dotenv.env['IOS_APP_ID'] ?? '',
    messagingSenderId: dotenv.env['IOS_MESSAGING_SENDER_ID'] ?? '',
    projectId: dotenv.env['WEB_PROJECT_ID'] ?? '',
    storageBucket: dotenv.env['WEB_STORAGE_BUCKET'] ?? '',
    iosClientId: dotenv.env['IOS_CLIENT_ID'] ?? '',
    iosBundleId: dotenv.env['IOS_BUNDLE_ID'] ?? '',
  );

  static final FirebaseOptions macos = FirebaseOptions(
    apiKey: dotenv.env['MACOS_API_KEY'] ?? '',
    appId: dotenv.env['MACOS_APP_ID'] ?? '',
    messagingSenderId: dotenv.env['MACOS_MESSAGING_SENDER_ID'] ?? '',
    projectId: dotenv.env['WEB_PROJECT_ID'] ?? '',
    storageBucket: dotenv.env['WEB_STORAGE_BUCKET'] ?? '',
    iosClientId: dotenv.env['MACOS_CLIENT_ID'] ?? '',
    iosBundleId: dotenv.env['MACOS_BUNDLE_ID'] ?? '',
  );
}
