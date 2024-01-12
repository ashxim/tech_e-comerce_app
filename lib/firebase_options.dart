// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAVDpWFzXqVbBH-cXI6R8UYPno81mASHYM',
    appId: '1:843673732261:web:3b49b7253d74ac5889f94c',
    messagingSenderId: '843673732261',
    projectId: 'my-e-comerce-app-2bb1a',
    authDomain: 'my-e-comerce-app-2bb1a.firebaseapp.com',
    storageBucket: 'my-e-comerce-app-2bb1a.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCmW1Q20lseRiH9uLNchN4_YT4q9TX5wcE',
    appId: '1:843673732261:android:e5b827b63b1e723389f94c',
    messagingSenderId: '843673732261',
    projectId: 'my-e-comerce-app-2bb1a',
    storageBucket: 'my-e-comerce-app-2bb1a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCNGVPDdKqs8g88_g4nlgYbo71EFGDKtUU',
    appId: '1:843673732261:ios:c6478d0a851777ce89f94c',
    messagingSenderId: '843673732261',
    projectId: 'my-e-comerce-app-2bb1a',
    storageBucket: 'my-e-comerce-app-2bb1a.appspot.com',
    iosBundleId: 'com.example.myEcomerceApp',
  );
}
