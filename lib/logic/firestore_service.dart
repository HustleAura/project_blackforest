// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:project_blackforest/constants/strings.dart';
import 'package:project_blackforest/data/models/message_model.dart';

import 'authentication_cubit/authentication_cubit.dart';

class FireStoreService {
  final FirebaseFirestore firebaseFirestoreInstance;

  FireStoreService({
    required this.firebaseFirestoreInstance,
  });

  Future<void> addMessageToFireBase(
    String message,
    String sender,
    String receiver,
  ) async {
    DocumentReference messageReferrence =
        await firebaseFirestoreInstance.collection(Message_Collection).add(
              messageToMap(
                message,
                sender,
                receiver,
              ),
            );

    Message lastMessage = Message(
      messageId: messageReferrence.id,
      message: message,
      senderEmail: sender,
      receiverEmail: receiver,
    );

    await addMessageToSender(lastMessage);
    await addMessageToReceiver(lastMessage);
    return;
  }

  Future<void> addMessageToSender(Message message) async {
    final senderReferrence = firebaseFirestoreInstance
        .collection(Chats_Collection)
        .doc(message.senderEmail);

    await senderReferrence.update(
      {
        'messageArray': FieldValue.arrayUnion(
          [
            message.messageId,
          ],
        ),
      },
    );
  }

  Future<void> addMessageToReceiver(Message message) async {
    final receiverReferrence = firebaseFirestoreInstance
        .collection(Chats_Collection)
        .doc(message.receiverEmail);

    await receiverReferrence.update(
      {
        'messageArray': FieldValue.arrayUnion(
          [
            message.messageId,
          ],
        ),
      },
    );
  }

  Stream personalChats(String senderEmail, String receiverEmail) {
    final userRef = firebaseFirestoreInstance
        .collection(Chats_Collection)
        .doc(senderEmail)
        .collection(receiverEmail);

    return userRef.snapshots();
  }

  Stream contactList(String userEmail) {
    final userRef =
        firebaseFirestoreInstance.collection(Contact_Collection).doc(userEmail);

    return userRef.snapshots();
  }
}

Future<DocumentSnapshot<Map<String, dynamic>>> getUserReferrence(
    BuildContext context, String collection) async {
  var currentUser = context
      .read<AuthenticationCubit>()
      .firebaseAuthInstance
      .currentUser!
      .email;

  return context
      .read<FireStoreService>()
      .firebaseFirestoreInstance
      .collection(collection)
      .doc(currentUser)
      .get();
}
