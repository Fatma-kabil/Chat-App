import 'package:chat_app/constant.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/widgets/chat_buble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});
  static String ID = 'ChatPage';

  CollectionReference messages =
      FirebaseFirestore.instance.collection(kcollectionmessages);
  TextEditingController controller = TextEditingController();
  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments as String;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy('created at', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messagesList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messagesList.add(Message.fromJsov(snapshot.data!.docs[i]));
          }
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
                  child: ListView.builder(
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
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (data) {
                      sendMessage(data, email);
                    },
                    cursorColor: kPrimaryColor,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            // Send message when send button is pressed
                            sendMessage(controller.text, email);
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
                            borderSide:
                                const BorderSide(color: kPrimaryColor))),
                  ),
                )
              ],
            ),
          );
        } else {
          return Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.white,
            child: Center(
              child: LoadingAnimationWidget.waveDots(
                color: kPrimaryColor,
                size: 75,
              ),
            ),
          );
        }
      },
    );
  }

  // Function to send message
  void sendMessage(String data, String email) {
    if (data.trim().isNotEmpty) {
      messages.add({
        kMessage: data,
        'created at': DateTime.now(),
        'id': email,
      });
      controller.clear();
      _controller.animateTo(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
    }
  }
}
