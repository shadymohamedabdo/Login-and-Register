import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'auth/HomaPage.dart';
import 'auth/login.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options:  const FirebaseOptions(
          // after working email&pass
          appId: 'com.example.shady', //from build gradle in app
          apiKey: 'AIzaSyBKhN9xnbYSSybIPzzQSYXYljFzXTMaLkQ', // from your project in firebase(Web API Key )
          messagingSenderId: '624753077208', //from your project in firebase in Cloud Messaging(Sender ID)
          projectId: 'shady-dce4c' //general
      )
  );
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // to know your condition on application(optional)
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
        // to have not login in every time
      home: FirebaseAuth.instance.currentUser != null &&
          // to force him Verified his email before logging
          FirebaseAuth.instance.currentUser!.emailVerified ? HomePage() : Login(),
    );
  }
}

