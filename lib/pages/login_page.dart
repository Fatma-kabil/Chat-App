import 'package:chat_app/constant.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../helpers/show_snack_bar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static String ID = 'LoginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formkey = GlobalKey();

  bool isloading = false;
  String? email;

  String? password;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isloading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: formkey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 90,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      klogo,
                      height: 150,
                      width: 150,
                    ),
                    const Text(
                      'ChatSphere',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                        fontFamily: 'Playwrite Cuba',
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 110,
                ),
                const Text(
                  'LOGIN',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 22,
                      fontFamily: 'Dosis'),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  onchanged: (value) {
                    email = value;
                  },
                  hintText: 'Email',
                  icon: const Icon(Icons.email),
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextField(
                  obscureText: true,
                  onchanged: (value) {
                    password = value;
                  },
                  hintText: 'Password',
                  icon: const Icon(Icons.remove_red_eye),
                ),
                const SizedBox(
                  height: 40,
                ),
                CustomButton(
                  text: 'LOGIN',
                  onTap: () async {
                    if (formkey.currentState!.validate()) {
                      isloading = true;
                      setState(() {});

                      try {
                        await loginUser();
                        Navigator.pushNamed(context, ChatPage.ID,
                            arguments: email);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          showSnakBar(context, 'No user found for that email.');
                        } else if (e.code == 'wrong-password') {
                          showSnakBar(context,
                              'Wrong password provided for that user.');
                        }
                      }
                      isloading = false;
                      setState(() {});
                    } else {}
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'don’t have an account?',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontFamily: 'Dosis',
                          fontWeight: FontWeight.w500),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          RegisterPage.ID,
                          (Route<dynamic> route) => false,
                        );
                      },
                      child: const Text(
                        '    Register',
                        style: TextStyle(
                            color: Color(0xff9CDBA6),
                            fontSize: 17,
                            fontFamily: 'Dosis',
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
