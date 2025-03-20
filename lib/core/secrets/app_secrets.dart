import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppSecrets {
  static String get supabaseUrl => dotenv.env['supabaseUrl'] ?? '';
  static String get supabaseAnonKey => dotenv.env['supabaseAnonKey'] ?? '';
}
