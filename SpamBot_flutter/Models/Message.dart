import 'package:flutter/material.dart';

class Message {
  final String className;
  final String message;
  final String? userID;

  Message({required this.className, required this.message, this.userID});

  Map<String, dynamic> toMap() {
    return {'className': className, 'message': message, 'userID' : userID};
  }
}
