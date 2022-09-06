import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_blackforest/constants/colors.dart';
import 'package:project_blackforest/data/models/message_model.dart';

class MessageCard extends StatelessWidget {
  final String messageId;
  final String currUserEmail;
  const MessageCard({
    Key? key,
    required this.messageId,
    required this.currUserEmail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Message>(
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          return Card(
            color: (snapshot.data!.senderEmail == currUserEmail)
                ? primaryColor
                : whiteColor,
            child: Text(
              snapshot.data!.message,
              style: GoogleFonts.kanit(),
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      }),
    );
  }
}
