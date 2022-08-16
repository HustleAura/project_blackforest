import 'package:flutter/material.dart';

import '../../constants/enums.dart';

class Message {
  final String senderId;
  final String recieverId;
  final MessageType messageType;

  Message({
    required this.senderId,
    required this.recieverId,
    required this.messageType,
  });
}
