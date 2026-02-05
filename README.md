# pinterest

A new Flutter project.

## Splash Screen & App Icon

The app uses a Pinterest-style native splash (white background, centered logo) and the same logo for the app icon.

- **Native splash**: `flutter_native_splash` — config in `pubspec.yaml` under `flutter_native_splash`. Logo: `assets/images/splash_logo.png`. After changing the image or config, run:
  ```bash
  dart run flutter_native_splash:create
  ```
- **App icon**: `flutter_launcher_icons` — config in `pubspec.yaml` under `flutter_launcher_icons`. After changing the image or config, run:
  ```bash
  dart run flutter_launcher_icons
  ```

The native splash is preserved until the first Flutter frame is drawn, so the transition from splash to app is seamless.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
