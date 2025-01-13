import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SupabaseConfig {
  static String get supabaseUrl {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return dotenv.env['SUPABASE_URL_ANDROID'] ?? _throwMissingEnv('SUPABASE_URL_ANDROID');
      case TargetPlatform.iOS:
        return dotenv.env['SUPABASE_URL_IOS'] ?? _throwMissingEnv('SUPABASE_URL_IOS');
      case TargetPlatform.macOS:
        return dotenv.env['SUPABASE_URL_MACOS'] ?? _throwMissingEnv('SUPABASE_URL_MACOS');
      default:
        return dotenv.env['SUPABASE_URL_WEB'] ?? _throwMissingEnv('SUPABASE_URL_WEB');
    }
  }

  static String get supabaseAnonKey {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return dotenv.env['SUPABASE_ANON_KEY_ANDROID'] ?? _throwMissingEnv('SUPABASE_ANON_KEY_ANDROID');
      case TargetPlatform.iOS:
        return dotenv.env['SUPABASE_ANON_KEY_IOS'] ?? _throwMissingEnv('SUPABASE_ANON_KEY_IOS');
      case TargetPlatform.macOS:
        return dotenv.env['SUPABASE_ANON_KEY_MACOS'] ?? _throwMissingEnv('SUPABASE_ANON_KEY_MACOS');
      default:
        return dotenv.env['SUPABASE_ANON_KEY_WEB'] ?? _throwMissingEnv('SUPABASE_ANON_KEY_WEB');
    }
  }

  static String _throwMissingEnv(String key) {
    throw Exception('Environment variable $key is not set. Please add it to your .env file.');
  }
}
