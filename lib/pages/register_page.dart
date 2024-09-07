import 'package:chat_app/constant.dart';
import 'package:chat_app/helpers/show_snack_bar.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  static String ID = 'RegisterPage';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormState> formkey = GlobalKey();

  String? email;

  String? password;

  bool isloading = false;

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
                  'REGISTER',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Dosis'),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  onchanged: (data) {
                    email = data;
                  },
                  hintText: 'Email',
                  icon: const Icon(Icons.email),
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextField(
                  obscureText: true,
                  onchanged: (data) {
                    password = data;
                  },
                  hintText: 'Password',
                  icon: const Icon(Icons.remove_red_eye),
                ),
                const SizedBox(
                  height: 40,
                ),
                CustomButton(
                  text: 'REGISTER',
                  onTap: () async {
                    if (formkey.currentState!.validate()) {
                      isloading = true;
                      setState(() {});

                      try {
                        await registerUser();
                        Navigator.pushNamed(context, ChatPage.ID,
                            arguments: email);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          showSnakBar(context, 'weak-password');
                        } else if (e.code == 'email-already-in-use') {
                          showSnakBar(context, 'email-already-in-use');
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
                      'already have an account?',
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
                          LoginPage.ID,
                          (Route<dynamic> route) => false,
                        );
                      },
                      child: const Text(
                        '    Login',
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

  Future<void> registerUser() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
