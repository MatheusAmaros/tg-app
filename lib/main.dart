import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tg_app/view/app.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
     // ignore: prefer_const_constructors
     options: FirebaseOptions(
      apiKey: "AIzaSyAqKIVrPhRUWTHN-kJciPl-OM3tjMZi9XI",
      appId: "1:51092244440:web:a5cf296b43dedde4ad54ad",
      messagingSenderId: "51092244440",
      projectId: "sistg-89390",
    ),
  );
  runApp(App());
}
