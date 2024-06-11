import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shady/auth/login.dart';
import '../component/AwesomeDialog.dart';
import '../component/Button.dart';
import '../component/TextForm.dart';
import '../component/logo.dart';
import '../component/text.dart';
class Register extends StatefulWidget {
  const Register({super.key});
  @override
  State<Register> createState() => _LoginState();
}
class _LoginState extends State<Register> {
  var formstate = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.blue,
      ),
      body:
      Padding(
        padding: const EdgeInsets.all(7.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: formstate,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const customLogo(),
                const customText(title: 'Sign up', fontSize: 25,),
                const Text( 'Sign up for using app ',
                  style:TextStyle(color: Colors.grey) ,),
                const SizedBox(height: 10,),
                const customText(title: 'Username', fontSize: 18,),
                CustomTextForm(prefixIcon: const Icon(Icons.person_add_rounded), validator: 'please Entre your name ', hintText: 'Username', myController: username,),
                const customText(title: 'Email', fontSize: 20,),
                CustomTextForm(prefixIcon: const Icon(Icons.email_outlined), validator: 'please Entre your email ', hintText: 'Entre your email', myController: email,),
                const customText(title: 'Password', fontSize: 18,),
                CustomTextForm(
                  onFieldSubmitted: ( value)async{
                    if (formstate.currentState!.validate()){
                      // to create page
                      try {
                         await FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: email.text,
                          password: password.text,
                        );
                        FirebaseAuth.instance.currentUser!.sendEmailVerification();
                        Get.offAll(()=>const Login());
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          customDialog(context,'error','Wrong password',DialogType.error,);
                        } else if (e.code == 'email-already-in-use') {
                          customDialog(context,'error','The account already exists for that email',DialogType.error,);
                        }
                      } catch (e) {
                        customDialog(context,'error','$e',DialogType.error,);
                      }}
                  },
                  prefixIcon: const Icon(Icons.password),
                  validator: 'please Entre your password ',
                  hintText: 'Entre your password',
                  myController: password,
                ),
                customButton(
                  onPressed: ()async{
                 if (formstate.currentState!.validate()){
                   // to create page
                    try {
                     await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: email.text,
                        password: password.text,
                      );
                    FirebaseAuth.instance.currentUser!.sendEmailVerification();
                    Get.offAll(()=>const Login());
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        customDialog(context,'error','weak-password',DialogType.error,);
                      } else if (e.code == 'email-already-in-use') {
                        customDialog(context,'error','The account already exists for that email',DialogType.error,);
                      }
                    } catch (e) {
                      customDialog(context,'error','$e',DialogType.error,);
                    }}
                  },
                  color: Colors.blue
                  , text: 'Sign Up',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const customText(
                      title: 'Have an account ?',
                      fontSize: 14,
                    ),
                    TextButton(onPressed: (){
                      Get.offAll(()=>const Login());
                    },
                        child: const Text('Login',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
