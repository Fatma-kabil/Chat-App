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
    apiKey: 'AIzaSyBHIzlagJgFqxOwG2rwkwQi6VnWtfGTSic',
    appId: '1:904798682946:web:24af1383137778c72212db',
    messagingSenderId: '904798682946',
    projectId: 'chat-app-f4d9d',
    authDomain: 'chat-app-f4d9d.firebaseapp.com',
    storageBucket: 'chat-app-f4d9d.appspot.com',
    measurementId: 'G-DCYR6363R5',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDaMFpSIcEhzUuHEqjNFIsauBCZHNnLiZU',
    appId: '1:904798682946:android:d6d8ee2c1e8588d72212db',
    messagingSenderId: '904798682946',
    projectId: 'chat-app-f4d9d',
    storageBucket: 'chat-app-f4d9d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA5mbJw7k1a-JBp-_Yy5xRrNkt9hlAFnhU',
    appId: '1:904798682946:ios:6ae3207d70d70bec2212db',
    messagingSenderId: '904798682946',
    projectId: 'chat-app-f4d9d',
    storageBucket: 'chat-app-f4d9d.appspot.com',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA5mbJw7k1a-JBp-_Yy5xRrNkt9hlAFnhU',
    appId: '1:904798682946:ios:6ae3207d70d70bec2212db',
    messagingSenderId: '904798682946',
    projectId: 'chat-app-f4d9d',
    storageBucket: 'chat-app-f4d9d.appspot.com',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBHIzlagJgFqxOwG2rwkwQi6VnWtfGTSic',
    appId: '1:904798682946:web:d666778460ec088e2212db',
    messagingSenderId: '904798682946',
    projectId: 'chat-app-f4d9d',
    authDomain: 'chat-app-f4d9d.firebaseapp.com',
    storageBucket: 'chat-app-f4d9d.appspot.com',
    measurementId: 'G-3BNDVV497D',
  );

}