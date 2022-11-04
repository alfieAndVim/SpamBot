import 'package:provider/provider.dart';
import 'package:spambot_2/Models/message.dart';
import 'package:spambot_2/Repositories/MessageRepository.dart';
import 'package:flutter/material.dart';

class MessageViewModel {
  final MessageRepository _messageRepository = MessageRepository();

  Future addMessage(Message message) async {
    var result = await _messageRepository.addMessage(message);
    return result;
  }
}
