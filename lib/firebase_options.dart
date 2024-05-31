// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyCmNf6y0KtU4GsRcSdp8uOndgkktEn_2aY',
    appId: '1:142503795042:web:2b9704b4ba3285f1a4b43b',
    messagingSenderId: '142503795042',
    projectId: 'pushnotif-b3a5d',
    authDomain: 'pushnotif-b3a5d.firebaseapp.com',
    storageBucket: 'pushnotif-b3a5d.appspot.com',
    measurementId: 'G-Z460N77X7C',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB8wjP-HvOYxUjG2k8sHzrATN4KDF0b5xg',
    appId: '1:142503795042:android:f3e706b0dd28e26ca4b43b',
    messagingSenderId: '142503795042',
    projectId: 'pushnotif-b3a5d',
    storageBucket: 'pushnotif-b3a5d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBmTdNrVGgYo0LgMq8TxWC4EH8dfK-6w9U',
    appId: '1:142503795042:ios:a3633ed1b5613daca4b43b',
    messagingSenderId: '142503795042',
    projectId: 'pushnotif-b3a5d',
    storageBucket: 'pushnotif-b3a5d.appspot.com',
    iosBundleId: 'com.kraft.notif',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBmTdNrVGgYo0LgMq8TxWC4EH8dfK-6w9U',
    appId: '1:142503795042:ios:a3633ed1b5613daca4b43b',
    messagingSenderId: '142503795042',
    projectId: 'pushnotif-b3a5d',
    storageBucket: 'pushnotif-b3a5d.appspot.com',
    iosBundleId: 'com.kraft.notif',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCmNf6y0KtU4GsRcSdp8uOndgkktEn_2aY',
    appId: '1:142503795042:web:c3e5c759e64dac7aa4b43b',
    messagingSenderId: '142503795042',
    projectId: 'pushnotif-b3a5d',
    authDomain: 'pushnotif-b3a5d.firebaseapp.com',
    storageBucket: 'pushnotif-b3a5d.appspot.com',
    measurementId: 'G-4Z4BN0MLT7',
  );
}