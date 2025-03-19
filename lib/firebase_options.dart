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
    apiKey: 'AIzaSyCmek5cpYbL105FJKs0UKvtcx2Q_mig1nw',
    appId: '1:569517445383:web:bc294281139dc13c2835a2',
    messagingSenderId: '569517445383',
    projectId: 'fitnesstrack-736e5',
    authDomain: 'fitnesstrack-736e5.firebaseapp.com',
    storageBucket: 'fitnesstrack-736e5.firebasestorage.app',
    measurementId: 'G-YTTKGDC3XL',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDp_9iBb5Ya9fPvAc2MXgWnygY4-NwCRIY',
    appId: '1:569517445383:android:865e594b308dec042835a2',
    messagingSenderId: '569517445383',
    projectId: 'fitnesstrack-736e5',
    storageBucket: 'fitnesstrack-736e5.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDh7ApT6hmwg0ltJa3Nk1AFyJ9eOcWoCCE',
    appId: '1:569517445383:ios:def592b28cbf97e62835a2',
    messagingSenderId: '569517445383',
    projectId: 'fitnesstrack-736e5',
    storageBucket: 'fitnesstrack-736e5.firebasestorage.app',
    iosBundleId: 'com.example.untitled',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDh7ApT6hmwg0ltJa3Nk1AFyJ9eOcWoCCE',
    appId: '1:569517445383:ios:def592b28cbf97e62835a2',
    messagingSenderId: '569517445383',
    projectId: 'fitnesstrack-736e5',
    storageBucket: 'fitnesstrack-736e5.firebasestorage.app',
    iosBundleId: 'com.example.untitled',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCmek5cpYbL105FJKs0UKvtcx2Q_mig1nw',
    appId: '1:569517445383:web:a47e922b9a8b85032835a2',
    messagingSenderId: '569517445383',
    projectId: 'fitnesstrack-736e5',
    authDomain: 'fitnesstrack-736e5.firebaseapp.com',
    storageBucket: 'fitnesstrack-736e5.firebasestorage.app',
    measurementId: 'G-RPCMZY7608',
  );
}
