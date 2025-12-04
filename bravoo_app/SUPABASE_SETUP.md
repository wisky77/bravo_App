# Supabase Setup and Auth Flow (Bravoo App)

This document explains how Supabase was integrated into the Flutter app, how the authentication calls work, and how to run the app locally.

## What’s included
- Dependency: `supabase_flutter`
- Bootstrap client: `lib/core/supabase_client.dart`
- Auth wrapper: `lib/services/auth_service.dart`
- App init: `lib/main.dart` initializes Supabase before `runApp`
- Screens using auth:
  - Login: `lib/screens/login_screen.dart` (email + password sign-in)
  - Sign Up: `lib/screens/sign_up_screen.dart` (email + password sign-up)
  - Enter Email: `lib/screens/enter_email.dart` (sends OTP/magic link and then routes to Home as requested)
  - Home: `lib/screens/home_screen.dart` (post-auth landing screen)

## Dependencies
Added to `pubspec.yaml`:

```
dependencies:
  supabase_flutter: ^2.5.6
```

Run:
- `flutter pub get`

## Client initialization
`lib/core/supabase_client.dart`

```
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
    );
    _initialized = true;
  }

  static SupabaseClient get client => Supabase.instance.client;
}
```

`lib/main.dart` (call before `runApp`):

```
await SupabaseManager.init(
  supabaseUrl: '<YOUR_URL>',
  supabaseAnonKey: '<YOUR_ANON_KEY>',
);
```

In this project, the values are currently hard-coded in `main.dart` for development:
- URL: `https://ebebsuwuenushsnhajru.supabase.co`
- ANON KEY: `<redacted here>`

Recommended for production:
- Use `--dart-define` or a secrets manager. Example:
  - `flutter run --dart-define=SUPABASE_URL=... --dart-define=SUPABASE_ANON_KEY=...`
  - Then read via `const String.fromEnvironment('SUPABASE_URL')`

## Auth service
`lib/services/auth_service.dart` wraps Supabase Auth calls:

```
class AuthService {
  final _auth = SupabaseManager.client.auth;

  Future<AuthResponse> signUpWithPassword(String email, String password) =>
      _auth.signUp(email: email, password: password);

  Future<AuthResponse> signInWithPassword(String email, String password) =>
      _auth.signInWithPassword(email: email, password: password);

  Future<void> sendOtpEmail(String email) => _auth.signInWithOtp(
        email: email,
        emailRedirectTo: _redirectUri(),
      );

  Future<void> signOut() => _auth.signOut();

  Session? get currentSession => _auth.currentSession;
  Stream<AuthState> onAuthStateChange() => _auth.onAuthStateChange;

  String _redirectUri() => 'io.supabase.flutter://login-callback';
}
```

## Screens and flows
- Login (`login_screen.dart`):
  - Collects email/password
  - Calls `AuthService().signInWithPassword(email, password)`
  - On success, currently navigates to `EnterEmailScreen` per the requested flow.
- Sign Up (`sign_up_screen.dart`):
  - Collects email/password
  - Calls `AuthService().signUpWithPassword(email, password)`
  - On success, navigates to `EnterEmailScreen` per the requested flow.
- Enter Email (`enter_email.dart`):
  - Validates email
  - Calls `AuthService().sendOtpEmail(email)`
  - On success, automatically routes to `/home` without waiting for the deep-link (requested behavior for local/dev).
- Home (`home_screen.dart`):
  - Simple landing screen after auth.

## Deep-link (optional for production)
For real OTP/magic link and OAuth flows, you must configure deep links. The redirect URI in `AuthService` is `io.supabase.flutter://login-callback`.

- Android `AndroidManifest.xml`:
```
<intent-filter>
  <action android:name="android.intent.action.VIEW" />
  <category android:name="android.intent.category.DEFAULT" />
  <category android:name="android.intent.category.BROWSABLE" />
  <data android:scheme="io.supabase.flutter" android:host="login-callback" />
</intent-filter>
```

- iOS `ios/Runner/Info.plist`:
```
<key>CFBundleURLTypes</key>
<Array>
  <dict>
    <key>CFBundleURLSchemes</key>
    <array>
      <string>io.supabase.flutter</string>
    </array>
  </dict>
</Array>
```

In production, keep the navigation to Home gated by real session confirmation from `onAuthStateChange()` or by checking `Supabase.instance.client.auth.currentSession` after the deep link returns.

## Running the app (dev)
1) Ensure Flutter SDK and a device/emulator are ready.
2) Install dependencies:
   - `flutter pub get`
3) Run the app:
   - `flutter run`

If you want to switch to `--dart-define` secrets:
- Update `main.dart` to read from environment:
```
await SupabaseManager.init(
  supabaseUrl: const String.fromEnvironment('SUPABASE_URL'),
  supabaseAnonKey: const String.fromEnvironment('SUPABASE_ANON_KEY'),
);
```
- Launch with:
```
flutter run \
  --dart-define=SUPABASE_URL=https://YOUR_PROJECT.supabase.co \
  --dart-define=SUPABASE_ANON_KEY=YOUR_ANON_KEY
```

## Troubleshooting
- Android build tools:
  - Use AGP 8.9.1+ and Gradle 8.11.1+. JDK 17 is recommended.
- Windows symlinks:
  - Enable Developer Mode (`start ms-settings:developers`) to allow plugin symlinks.
- Memory issues on Windows:
  - Increase paging file, close heavy apps.
  - `android/gradle.properties` contains conservative settings:
    - `org.gradle.jvmargs=-Xmx4096m`
    - `kotlin.daemon.jvm.options=-Xmx2048m`
    - `kotlin.incremental=false`
    - `org.gradle.workers.max=2`
- OTP/magic link doesn’t go to Home (prod behavior):
  - Implement deep links (above), then navigate on `onAuthStateChange()` when a session is established.

## Notes
- The ANON KEY is public by design, but avoid checking it into source control for production. Use environment variables or a secrets manager.
- For Google/Apple OAuth, configure providers in the Supabase dashboard and use the same redirect scheme.

---
If you want, I can switch the dev behavior to only navigate to Home when a valid Supabase session is present, and add deep-link handling. Should I set that up next?
