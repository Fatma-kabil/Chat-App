import 'package:chat_app/constant.dart';
import 'package:chat_app/models/message.dart';
import 'package:flutter/material.dart';

class ChatBuble extends StatelessWidget {
  const ChatBuble({super.key, required this.message});
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
          padding:
              const EdgeInsets.only(left: 18, top: 25, bottom: 25, right: 18),
          margin: const EdgeInsets.all(12),
          //  alignment: Alignment.centerLeft,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(29),
              topLeft: Radius.circular(29),
              topRight: Radius.circular(29),
            ),
            color: kPrimaryColor,
          ),
          child: Text(
            message.message,
            style: const TextStyle(color: Colors.white, fontSize: 17),
          )),
    );
  }
}

class ChatBubleForFriend extends StatelessWidget {
  const ChatBubleForFriend({super.key, required this.message});
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
          padding:
              const EdgeInsets.only(left: 18, top: 25, bottom: 25, right: 18),
          margin: const EdgeInsets.all(12),
          //  alignment: Alignment.centerLeft,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(29),
              topLeft: Radius.circular(29),
              topRight: Radius.circular(29),
            ),
            color: Color.fromARGB(145, 8, 33, 54),
          ),
          child: Text(
            message.message,
            style: const TextStyle(color: Colors.white, fontSize: 17),
          )),
    );
  }
}
