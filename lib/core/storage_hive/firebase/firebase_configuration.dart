import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
        throw UnsupportedError(
            'DefaultFirebaseOptions are not supported for this platform.');
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'your-api-key',
    authDomain: 'your-auth-domain',
    databaseURL:
        'https://business-manager-25393-default-rtdb.europe-west1.firebasedatabase.app',
    projectId: 'business-manager-25393',
    storageBucket: 'business-manager-25393.appspot.com',
    messagingSenderId: '1034468450801',
    appId: 'your-web-app-id',
    measurementId: 'your-measurement-id',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBfz9Omnwo7qEnExoxJbOttRvSfDhHtYY4',
    appId: '1:1034468450801:android:93590d7ea0e7f0ba006450',
    messagingSenderId: '1034468450801',
    projectId: 'business-manager-25393',
    storageBucket: 'business-manager-25393.appspot.com',
    databaseURL:
        'https://business-manager-25393-default-rtdb.europe-west1.firebasedatabase.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'your-api-key',
    appId: 'your-ios-app-id',
    messagingSenderId: 'your-ios-messaging-sender-id',
    projectId: 'business-manager-25393',
    storageBucket: 'business-manager-25393.appspot.com',
    iosClientId: 'your-ios-client-id',
    iosBundleId: 'com.example.businessManager',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'your-api-key',
    appId: 'your-macos-app-id',
    messagingSenderId: 'your-macos-messaging-sender-id',
    projectId: 'business-manager-25393',
    storageBucket: 'business-manager-25393.appspot.com',
    iosClientId: 'your-macos-client-id',
    iosBundleId: 'com.example.businessManager',
  );
}
