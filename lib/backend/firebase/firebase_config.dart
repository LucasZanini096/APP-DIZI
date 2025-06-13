import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyD_H5VuZPi6XW520F7qkKp_bkikrB5AthY",
            authDomain: "dizi-5f248.firebaseapp.com",
            projectId: "dizi-5f248",
            storageBucket: "dizi-5f248.firebasestorage.app",
            messagingSenderId: "532842959139",
            appId: "1:532842959139:web:e38bdbb8ca13db195bbc96",
            measurementId: "G-1KCLG8B6Y1"));
  } else {
    await Firebase.initializeApp();
  }
}
