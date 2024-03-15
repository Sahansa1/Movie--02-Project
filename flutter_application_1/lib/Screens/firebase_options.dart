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
   // ignore: missing_enum_constant_in_switch
   switch (defaultTargetPlatform) {
  case TargetPlatform.android:
    return android;
  case TargetPlatform.iOS:
    return ios;
  case TargetPlatform.macOS:
    return macos;
  default:
    throw UnsupportedError("Platform not supported");
}

   throw UnsupportedError(
     'DefaultFirebaseOptions are not supported for this platform.',
   );
 }
// FirebaseOptions for web platform
 static const FirebaseOptions web = FirebaseOptions(
   apiKey: 'AIzaSyBrSwe7RMKMICi7HNMfntHdJ903EuwQgjA',
   appId: '1:649394853723:android:1cd1231a1ac513ffb72c7e',
   messagingSenderId: '391914913675',
   projectId: 'bingewatch-3da29',
   authDomain: 'flutterfire-ui-codelab.firebaseapp.com',
   storageBucket: 'flutterfire-ui-codelab.appspot.com',
   measurementId: 'G-DGF0CP099H',
 );
// FirebaseOptions for android platform
 static const FirebaseOptions android = FirebaseOptions(
   apiKey: 'AIzaSyBrSwe7RMKMICi7HNMfntHdJ903EuwQgjA',
   appId: '1:649394853723:android:1cd1231a1ac513ffb72c7e',
   messagingSenderId: '391914913675',
   projectId: 'bingewatch-3da29',
   storageBucket: 'flutterfire-ui-codelab.appspot.com',
 );

 // FirebaseOptions for macOS platform
 static const FirebaseOptions ios = FirebaseOptions(
   apiKey: 'AIzaSyBrSwe7RMKMICi7HNMfntHdJ903EuwQgjA',
   appId: '1:963656261848:ios:d9e01cfe8b675dfcb237ad',
   messagingSenderId: '391914913675',
   projectId: 'bingewatch-3da29',
   storageBucket: 'flutterfire-ui-codelab.appspot.com',
   iosClientId: '963656261848-v7r3vq1v6haupv0l1mdrmsf56ktnua60.apps.googleusercontent.com',
   iosBundleId: 'com.example.complete',
 );

 static const FirebaseOptions macos = FirebaseOptions(
   apiKey: 'AIzaSyBrSwe7RMKMICi7HNMfntHdJ903EuwQgjA',
   appId: '1:963656261848:ios:d9e01cfe8b675dfcb237ad',
   messagingSenderId: '391914913675',
   projectId: 'bingewatch-3da29',
   storageBucket: 'flutterfire-ui-codelab.appspot.com',
   iosClientId: '963656261848-v7r3vq1v6haupv0l1mdrmsf56ktnua60.apps.googleusercontent.com',
   iosBundleId: 'com.example.complete',
 );
}