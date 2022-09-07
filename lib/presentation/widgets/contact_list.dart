import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_blackforest/constants/strings.dart';
import 'package:project_blackforest/presentation/widgets/contact_tile.dart';

import '../../data/models/user_model.dart';

Future<List<Widget>> contactList(
  List<dynamic> contactArray,
  FirebaseFirestore firebaseFirestoreInstance,
) async {
  List<Widget> contactList = [Text('sample')];
  for (var i = 0; i < contactArray.length; i++) {
    final userName = await firebaseFirestoreInstance
        .collection(User_Collection)
        .doc(contactArray[i].toString())
        .get();

    contactList.add(
      ContactTile(
        user: AppUser(
          name: userName.data()!['name'],
          email: contactArray[i].toString(),
        ),
      ),
    );
  }

  return contactList;
}

class ContactList extends StatelessWidget {
  final List<dynamic> contactArray;
  final FirebaseFirestore firebaseFirestoreInstance;
  const ContactList({
    Key? key,
    required this.contactArray,
    required this.firebaseFirestoreInstance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Widget>>(
      future: contactList(contactArray, firebaseFirestoreInstance),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasData) {
          return ListView(
            shrinkWrap: true,
            children: snapshot.data ?? [],
          );
        } else {
          return Text('Oops! Something went wrong. Please try again later');
        }
      }),
    );
  }
}
