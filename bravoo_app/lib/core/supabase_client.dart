import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseManager {
  static bool _initialized = false;

  static Future<void> init({
    required String supabaseUrl,
    required String supabaseAnonKey,
  }) async {
    if (_initialized) return;
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
      // Removed authFlowType for compatibility with current supabase_flutter version
    );
    _initialized = true;
  }

  static SupabaseClient get client => Supabase.instance.client;
}
