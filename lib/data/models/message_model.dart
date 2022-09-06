import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_blackforest/constants/strings.dart';
import 'package:project_blackforest/logic/firestore_service.dart';

import '../../constants/enums.dart';

Map<String, dynamic> messageToMap(
  String message,
  String sender,
  String receiver,
) {
  Map<String, dynamic> map = {};
  map['message'] = message;
  map['senderEmail'] = sender;
  map['receiverEmail'] = receiver;

  return map;
}

Future<Message> messageFromId(
  String messageId,
  FirebaseFirestore firebaseFirestoreInstance,
) async {
  final messageRef = await firebaseFirestoreInstance
      .collection(Message_Collection)
      .doc(messageId)
      .get();

  return Message.fromMap(messageId, messageRef.data()!);
}

class Message {
  final String messageId;
  late String message;
  late String senderEmail;
  late String receiverEmail;

  Message({
    required this.messageId,
    required this.message,
    required this.senderEmail,
    required this.receiverEmail,
  });

  Message.fromMap(this.messageId, Map<String, dynamic> messageMap) {
    message = messageMap['message'];
    senderEmail = messageMap['senderEmail'];
    receiverEmail = messageMap['receiverEmail'];
  }
}
