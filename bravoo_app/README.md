# Bravoo App

A Flutter mobile application for Bravoo.

## Project Structure

```
bravoo_app/
├── lib/
│   ├── main.dart              # App entry point
│   ├── screens/               # UI screens
│   │   └── splash_screen.dart
│   ├── widgets/               # Reusable widgets
│   └── theme/                 # Design system
│       ├── app_colors.dart
│       └── app_theme.dart
├── assets/
│   └── images/                # Image assets
└── test/                      # Unit tests
```

## Getting Started

### Prerequisites
- Flutter SDK (3.0.0 or higher)
- Dart SDK
- Android Studio / Xcode

### Installation

1. Install dependencies:
```bash
flutter pub get
```

2. Run the app:
```bash
flutter run
```

### Build for Production

Android:
```bash
flutter build apk --release
```

iOS:
```bash
flutter build ios --release
```

## Features

- Splash screen with brand logo and gradient background
- Clean, modern UI design
- Responsive layout

## Design System

### Colors
- Primary Purple: `#7C3AED`
- Primary Purple Dark: `#6D28D9`
- Gradient: `#7C3AED` to `#8B5CF6`

### Typography
- Brand Name: 32px, Weight 600, Letter Spacing 8px
