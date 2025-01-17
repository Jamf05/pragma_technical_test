# Pragma Technical Test App [![Codemagic build status](https://api.codemagic.io/apps/66671f8977f25d5306ab0e7f/66671f8977f25d5306ab0e7e/status_badge.svg)](https://codemagic.io/apps/66671f8977f25d5306ab0e7f/66671f8977f25d5306ab0e7e/latest_build)

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/jorgemogotocoro/) [![Twitter](https://img.shields.io/badge/Twitter-1DA1F2?style=for-the-badge&logo=twitter&logoColor=white)](https://twitter.com/MogotocoroJorge) [![Gmail](https://img.shields.io/badge/Gmail-D14836?style=for-the-badge&logo=gmail&logoColor=white)](mailto:jorgemogotocoro05@outlook.es)

A simple Flutter application.

To download this app, click here to see the [codemagic builds](https://codemagic.io/app/66671f8977f25d5306ab0e7f/build/66672896b3bd3d4a1c058326). You can choose to install the apk or the ipa(ios).

> Please star ⭐ the repo if you like what you see 😉.

## 📝 Requirements

- Any Operating System (ie. MacOS X, Linux, Windows)
- Any IDE with Flutter SDK installed (ie. IntelliJ, Android Studio, VSCode etc)
- A little knowledge of Dart and Flutter
- Version summary:

    ```plain
    Flutter (Channel stable, 3.22.3, on macOS 14.6.1 23G93 darwin-arm64, locale es-CO)
    • Flutter version 3.22.3 on channel stable at /Users/jamf-mac/fvm/versions/3.22.3
    • Upstream repository https://github.com/flutter/flutter.git
    • Framework revision b0850beeb2 (6 months ago), 2024-07-16 21:43:41 -0700
    • Engine revision 235db911ba
    • Dart version 3.4.4
    • DevTools version 2.34.3
    ```

## Project Structure

This project follows the guidelines of clean architecture.

![CleanArchitecture](screenshots/CleanArchitecture.webp)

## 💡 Features

- [x] Internationalization. Support for English and Spanish languages.
- [x] Error Handling.
- [x] Dependency injection.
- [x] Lazy image loading.
- [x] Dark theme and light theme.

## 🔌 Packages

| Name                                                                              | Usage                                               |
| --------------------------------------------------------------------------------- | --------------------------------------------------- |
| [**Another Flushbar**](https://pub.dev/packages/another_flushbar)                 | A flexible widget for user notification             |
| [**BLoC**](https://pub.dev/packages/bloc)                                         | State Management                                    |
| [**cached_network_image**](https://pub.dev/packages/cached_network_image)         | Library to load and cache network images            |
| [**Dartz**](https://pub.dev/packages/dartz)                                       | Functional Error Handling                           |
| [**Dio**](https://pub.dev/packages/dio)                                           | HTTP networking package                             |
| [**rxdart**](https://pub.dev/packages/rxdart)                                     | State Management                                    |
| [**Dartz**](https://pub.dev/packages/dartz)                                       | Functional Error Handling                           |

## 🚀 Getting Started

```bash
    flutter gen-l10n
    flutter packages pub run build_runner build --delete-conflicting-outputs
    flutter run
````

## 🧪 Testing (Linux)

```bash
    flutter packages pub run build_runner build --delete-conflicting-outputs
    flutter test
````

## 👨‍💻 Author(s)

[**Jorge A. Mogotocoro F.**](https://www.linkedin.com/in/jorgemogotocoro/)
