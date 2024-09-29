import 'package:chat_app/constant.dart';
import 'package:chat_app/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/widgets/chat_buble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});
  static String ID = 'ChatPage';

  TextEditingController controller = TextEditingController();
  final _controller = ScrollController();
  List<Message> messagesList = [];

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              klogo,
              height: 45,
            ),
            const Text(
              ' chat',
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: BlocConsumer<ChatCubit, ChatState>(
            listener: (context, state) {
              if (state is ChatSuccess) {
                messagesList = state.messages;
              }
            },
            builder: (context, state) {
              return ListView.builder(
                reverse: true,
                controller: _controller,
                itemCount: messagesList.length,
                itemBuilder: (context, index) {
                  return messagesList[index].id == email
                      ? ChatBuble(
                          message: messagesList[index],
                        )
                      : ChatBubleForFriend(message: messagesList[index]);
                },
              );
            },
          )),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: controller,
              onSubmitted: (data) {
                controller.clear();
                _controller.animateTo(
                  0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                );
              },
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      // Send message when send button is pressed

                      controller.clear();
                      _controller.animateTo(
                        0,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );
                    },
                    icon: const Icon(Icons.send),
                    color: kPrimaryColor,
                  ),
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                  ),
                  hintText: 'Send Message',
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: kPrimaryColor)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: kPrimaryColor))),
            ),
          )
        ],
      ),
    );
  }
} 
  

  // Function to send message
 