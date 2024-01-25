import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseproject/dataStore.dart';
import 'package:firebaseproject/firebase_options.dart';
import 'package:flutter/material.dart';

void main() async {
  try {
    await WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
        options: await DefaultFirebaseOptions.currentPlatform);
  } catch (e, stackTrace) {
    print("Error during initialization: $e");
    print("Stacktrace during initialization: $stackTrace");
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: dataStore(),
    );
  }
}

