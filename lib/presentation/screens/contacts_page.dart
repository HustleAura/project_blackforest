import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_blackforest/logic/authentication_cubit/authentication_cubit.dart';
import 'package:project_blackforest/logic/firestore_service.dart';
import 'package:project_blackforest/presentation/widgets/contact_list.dart';
import 'package:project_blackforest/presentation/widgets/search_bar.dart';
import 'package:provider/provider.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firestoreServiceInstance = context.read<FireStoreService>();
    final currUser =
        context.read<AuthenticationCubit>().firebaseAuthInstance.currentUser!;

    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Saved Contacts",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding:
                        EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2),
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.pink[50],
                    ),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.add,
                          color: Colors.pink,
                          size: 20,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          "Add New",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SearchBar(),
          StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: firestoreServiceInstance.contactList(currUser.email!),
            builder: ((context, snapshot) {
              final contactArray = snapshot.data!.data()!['contactArray'];
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else {
                return ContactList(
                  contactArray: contactArray,
                  firebaseFirestoreInstance:
                      firestoreServiceInstance.firebaseFirestoreInstance,
                );
              }
            }),
          )
        ],
      ),
    );
  }
}
