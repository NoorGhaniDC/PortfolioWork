<<<<<<< HEAD
# FitTrack - Fitness Application

A comprehensive cross-platform fitness tracking application built with Flutter, featuring user authentication, workout logging, and real-time progress monitoring powered by Firebase.

**Developers:** Noor Ghani, Buianto Sodnomov, Nehan Hossain  
**Academic Year:** 2025-26  
**Institution:** Durham College  

## Overview

FitTrack is a modern mobile fitness application that helps users track their fitness goals, log workouts, monitor progress, and maintain a healthy lifestyle. Built with Flutter, it provides a seamless experience across iOS, Android, macOS, Windows, Linux, and web platforms.

## Technology Stack

- **Framework:** Flutter 3.9.2+
- **Backend:** Firebase (Authentication, Firestore Database)
- **State Management:** Provider
- **Authentication:** Firebase Auth
- **UI Components:** Material Design

## Features

- 🔐 **User Authentication:** Secure Firebase authentication
- 📊 **Workout Logging:** Track exercises, sets, reps, and duration
- 📈 **Progress Tracking:** Visualize fitness progress over time
- 💾 **Cloud Sync:** Real-time synchronization with Firestore
- 📱 **Cross-Platform:** iOS, Android, macOS, Windows, Linux, and Web
- 🔔 **Data Persistence:** Local storage with shared_preferences
- 📅 **Date & Time Support:** International date/time formatting with intl package
- 🔍 **App Security:** Firebase App Check protection

## Project Structure

```
FitTrack/
├── lib/                    # Main source code
│   ├── main.dart          # Application entry point
│   ├── screens/           # Application screens/pages
│   ├── models/            # Data models
│   ├── providers/         # State management (Provider)
│   ├── widgets/           # Custom widgets
│   ├── services/          # Firebase and API services
│   └── utils/             # Utility functions and constants
├── android/               # Android platform code
├── ios/                   # iOS platform code
├── macos/                 # macOS platform code
├── windows/               # Windows platform code
├── linux/                 # Linux platform code
├── web/                   # Web platform code
├── pubspec.yaml          # Dependencies and project configuration
├── analysis_options.yaml # Dart analysis configuration
└── README.md             # This file
```

## Dependencies

Key packages used in the project:

- **firebase_core**: Firebase initialization
- **firebase_auth**: User authentication
- **cloud_firestore**: Cloud database
- **firebase_app_check**: Security and app verification
- **provider**: State management
- **shared_preferences**: Local data persistence
- **intl**: Internationalization and localization

## Getting Started

### Prerequisites

- Flutter SDK 3.9.2 or higher
- Dart 3.x
- Firebase project setup
- Platform-specific requirements (Xcode for iOS, Android Studio for Android, etc.)

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd FitTrack
```

2. Install Flutter dependencies:
```bash
flutter pub get
```

3. Configure Firebase:
   - Create a Firebase project at [firebase.google.com](https://firebase.google.com)
   - Download configuration files:
     - `google-services.json` for Android → `android/app/`
     - `GoogleService-Info.plist` for iOS → `ios/Runner/`
   - Configure FlutterFire CLI: `flutterfire configure`

4. (Optional) Code generation:
```bash
flutter pub run build_runner build
```

### Development

Run the app on your connected device or emulator:
```bash
flutter run
```

For specific platforms:
```bash
# Android
flutter run -d android

# iOS
flutter run -d ios

# Web
flutter run -d web

# Windows
flutter run -d windows

# macOS
flutter run -d macos

# Linux
flutter run -d linux
```

### Building

Build release versions:
```bash
# Android APK
flutter build apk

# iOS App
flutter build ios

# Web
flutter build web

# Windows executable
flutter build windows

# macOS app
flutter build macos

# Linux application
flutter build linux
```

## Directory Overview

- **screens/** - UI screens and pages (login, workouts, dashboard, etc.)
- **models/** - Data classes and models
- **providers/** - ChangeNotifier and state management logic
- **widgets/** - Reusable custom widgets
- **services/** - Firebase services and API integrations
- **utils/** - Constants, helpers, and utility functions

## Configuration

Update Firebase configuration details in the Firebase console and ensure platform-specific configuration files are in place.

## Testing

Run tests with:
```bash
flutter test
```

## Linting and Analysis

Check code quality:
```bash
flutter analyze
```

Format code:
```bash
dart format .
```

## Troubleshooting

### Firebase Connection Issues
- Ensure `google-services.json` and `GoogleService-Info.plist` are properly configured
- Check Firebase project settings and authentication methods

### Build Errors
- Run `flutter clean` and `flutter pub get` to reset dependencies
- Check platform-specific requirements (iOS Deployment Target, Android SDK Version)

### State Management
- Provider is used for state management; ensure ChangeNotifiers are properly disposed

## Contributing

This is an academic project for Durham College coursework. Contributions from team members are integrated through collaborative development.

## License

Academic project - Created for Durham College coursework

## Contact

For questions or issues related to this project, please contact the development team at Durham College.
=======
Fit Track

Description:

A flutter mobile application that is used to track workouts.

Technologies:
- Flutter
- Dart
- Android Studio
- Firebase
- Git

Features:
- Log and track workouts to user profile.
- Create and customize profile.
- Generates workouts based on user profile.



Authors:
Noor Ghani, Nehan Hossain, & Buianto Sodnomov


This application was designed and developed by Noor Ghani, Buianto Sodnomov, and Nehan Hossain as a part
of their coursework for Durham College in the 2025-26 academic year.
>>>>>>> 0535b048eac0f8cbecd9cb6e655b168a77b19664
