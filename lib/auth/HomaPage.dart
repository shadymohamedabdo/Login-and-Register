import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shady/component/text.dart';
import 'login.dart';
class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: ()async{
                // to do disconnect from gmail
                GoogleSignIn google = GoogleSignIn();
                google.disconnect();
                // to do signOut from account
                await FirebaseAuth.instance.signOut();
                Get.offAll(()=>Login());
              },
              icon: Icon(Icons.exit_to_app_outlined))
        ],
        backgroundColor: Colors.blue,
        title: customText(
          title: 'Firebase install ', fontSize: 22,

        ),
        centerTitle: true,
      ),
      body: Column(
        children: [

        ],
      ),
    );
  }
}
