import 'package:chat_app/constant.dart';
import 'package:chat_app/cubits/login_cubit/login_cubit.dart';
import 'package:chat_app/cubits/register_cubit/register_cubit.dart';
import 'package:chat_app/helpers/show_snack_bar.dart';
import 'package:chat_app/pages/chat_page.dart';

import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  static String ID = 'RegisterPage';

  GlobalKey<FormState> formkey = GlobalKey();

  String? email;

  String? password;

  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          isloading = true;
        } else if (state is RegisterSuccess) {
          Navigator.pushNamed(context, ChatPage.ID, arguments: email);
        } else if (state is RegisterFailure) {
          showSnakBar(context, state.errMassege);
          isloading = false;
        }
      },
      builder: (context, state) {
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
                          if (email != null && password != null) {
                            BlocProvider.of<LoginCubit>(context)
                                .loginUser(email: email!, password: password!);
                          } else {
                            showSnakBar(context,
                                'Please enter both email and password');
                          }
                        }
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
      },
    );
  }
}
