import 'package:bloc/bloc.dart';
import 'package:chat_app/constant.dart';
import 'package:chat_app/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  CollectionReference messages =
      FirebaseFirestore.instance.collection(kcollectionmessages);

  void sendMessage({required String message, required String email}) {
    if (message.trim().isNotEmpty) {
      messages.add({
        kMessage: message,
        'created at': DateTime.now(),
        'id': email,
      });
    }
  }

  void getMessages() {
    messages.orderBy('created at', descending: true).snapshots().listen(
      (event) {
        List<Message> messagesList = [];
        for (var doc in event.docs) {
          messagesList.add(Message.fromJsov(doc));
        }
        emit(ChatSuccess(messages: messagesList));
      },
    );
  }
}
