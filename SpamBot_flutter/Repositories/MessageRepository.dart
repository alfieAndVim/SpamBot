import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:spambot_2/Models/message.dart';

class MessageRepository {
  final CollectionReference _messagesCollectionRef =
      FirebaseFirestore.instance.collection('messagesStore');

  Future addMessage(Message message) async {
    try {
      await _messagesCollectionRef.add(message.toMap());
      return 'success';
    } catch (error) {
      return error.toString();
    }
  }
}
