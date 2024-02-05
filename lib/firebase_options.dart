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
        return macos;
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
    apiKey: 'AIzaSyDhV-T1yx2hXMEkjKULZ_t8-WLyfZGT7KA',
    appId: '1:265495333677:web:55b437c07552dac9bca1a4',
    messagingSenderId: '265495333677',
    projectId: 'chat-app-f8b62',
    authDomain: 'chat-app-f8b62.firebaseapp.com',
    storageBucket: 'chat-app-f8b62.appspot.com',
    measurementId: 'G-N84997SZWP',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyApiBIdQpQ2fjxHU-ldewYlyEDC2_UvLog',
    appId: '1:265495333677:android:0af6580d4a9dcdf9bca1a4',
    messagingSenderId: '265495333677',
    projectId: 'chat-app-f8b62',
    storageBucket: 'chat-app-f8b62.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAyqITTTXD-hxfPrp2LS4fp58HSSSESBhQ',
    appId: '1:265495333677:ios:a23d636133ddcca5bca1a4',
    messagingSenderId: '265495333677',
    projectId: 'chat-app-f8b62',
    storageBucket: 'chat-app-f8b62.appspot.com',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAyqITTTXD-hxfPrp2LS4fp58HSSSESBhQ',
    appId: '1:265495333677:ios:e58f73af8f74205fbca1a4',
    messagingSenderId: '265495333677',
    projectId: 'chat-app-f8b62',
    storageBucket: 'chat-app-f8b62.appspot.com',
    iosBundleId: 'com.example.chatApp.RunnerTests',
  );
}