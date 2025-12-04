import 'package:supabase_flutter/supabase_flutter.dart';
import '../core/supabase_client.dart';

class AuthService {
  final _auth = SupabaseManager.client.auth;

  Future<AuthResponse> signUpWithPassword(String email, String password) async {
    return _auth.signUp(email: email, password: password);
  }

  Future<AuthResponse> signInWithPassword(String email, String password) async {
    return _auth.signInWithPassword(email: email, password: password);
  }

  Future<void> sendOtpEmail(String email) async {
    await _auth.signInWithOtp(
      email: email,
      emailRedirectTo: _redirectUri(),
    );
  }

  Future<void> signOut() => _auth.signOut();

  Session? get currentSession => _auth.currentSession;
  Stream<AuthState> onAuthStateChange() => _auth.onAuthStateChange;

  String _redirectUri() => 'io.supabase.flutter://login-callback';
}
