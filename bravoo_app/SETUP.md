# Bravoo App - Setup Guide

## Running Without Docker

### Option 1: Install Flutter Locally (Recommended)

#### Step 1: Install Flutter SDK

**macOS:**
```bash
# Download Flutter SDK
cd ~/development
git clone https://github.com/flutter/flutter.git -b stable

# Add Flutter to PATH (add to ~/.zshrc or ~/.bash_profile)
export PATH="$PATH:$HOME/development/flutter/bin"

# Reload shell
source ~/.zshrc
```

#### Step 2: Run Flutter Doctor
```bash
flutter doctor
```
This will check for any missing dependencies.

#### Step 3: Install Dependencies
```bash
cd bravoo_app
flutter pub get
```

#### Step 4: Run the App

**For Web:**
```bash
flutter run -d chrome
```

**For iOS Simulator:**
```bash
flutter run -d ios
```

**For Android Emulator:**
```bash
flutter run -d android
```

**List available devices:**
```bash
flutter devices
```

---

### Option 2: Use Android Studio / VS Code

#### Android Studio:
1. Download from: https://developer.android.com/studio
2. Install Flutter plugin: `Preferences > Plugins > Search "Flutter"`
3. Open `bravoo_app` folder
4. Click "Run" button

#### VS Code:
1. Install Flutter extension
2. Open `bravoo_app` folder
3. Press F5 or use Command Palette: `Flutter: Run Flutter App`

---

### Option 3: Online Development (No Installation)

Use **DartPad** for quick testing:
1. Visit: https://dartpad.dev
2. Copy/paste widget code
3. Run in browser

---

## Quick Flutter Installation (macOS)

```bash
# Using Homebrew (easiest method)
brew install --cask flutter

# Verify installation
flutter doctor

# Run the app
cd bravoo_app
flutter pub get
flutter run -d chrome
```

---

## Project Structure

```
bravoo_app/
├── lib/
│   ├── main.dart                    # Entry point
│   ├── screens/
│   │   ├── splash_screen.dart       # Splash screen
│   │   ├── login_screen.dart        # Login screen
│   │   └── forgot_password_screen.dart  # Forgot password
│   ├── widgets/
│   │   ├── custom_text_field.dart   # Reusable input field
│   │   ├── primary_button.dart      # Dark button
│   │   └── social_button.dart       # Social login button
│   └── theme/
│       ├── app_colors.dart          # Color palette
│       └── app_theme.dart           # App theme
└── pubspec.yaml                     # Dependencies
```

---

## Current App Screens

1. **Splash Screen** - Shows Bravoo logo with purple gradient (3s auto-navigation)
2. **Login Screen** - Email/password login with social auth options
3. **Forgot Password Screen** - Email input for password reset

---

## Troubleshooting

### "Flutter command not found"
- Ensure Flutter is in your PATH
- Run: `export PATH="$PATH:$HOME/development/flutter/bin"`

### "No devices available"
- For web: Run `flutter config --enable-web`
- For iOS: Open Xcode and launch iOS Simulator
- For Android: Launch Android Emulator from Android Studio

### Dependencies issues
```bash
flutter clean
flutter pub get
```

---

## Next Steps

1. Install Flutter SDK
2. Run `flutter pub get` in the `bravoo_app` directory
3. Run `flutter run -d chrome` to launch in browser
4. Or open the project in Android Studio/VS Code

---

## Support

For Flutter installation help:
- Official Guide: https://docs.flutter.dev/get-started/install/macos
- Flutter Doctor: https://docs.flutter.dev/get-started/install/macos#run-flutter-doctor
