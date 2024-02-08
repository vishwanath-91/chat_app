import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessages extends StatefulWidget {
  const NewMessages({super.key});

  @override
  State<NewMessages> createState() => _NewMessagesState();
}

class _NewMessagesState extends State<NewMessages> {
  final _messageController = TextEditingController();

  void _submitMessage() async {
    final enteredMessage = _messageController.text;
    if (enteredMessage.toString().trim().isEmpty) {
      return;
    } else {
      FocusScope.of(context).unfocus();
      _messageController.clear();
      final user = FirebaseAuth.instance.currentUser!;
      final userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (userData.exists) {
        // Check if userData exists before accessing its data
        await FirebaseFirestore.instance.collection("chat").add({
          'text': enteredMessage,
          'createdAt': Timestamp.now(), // Add the import for Timestamp
          'userId': user.uid,
          'username': userData.data()!['userName'],
          'userImage': userData.data()!['imageUrl'],
        });
      } else {
        // Handle the case where userData does not exist
        print('User data does not exist.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 7,
          child: Padding(
            padding: const EdgeInsets.only(left: 25),
            child: TextField(
              controller: _messageController,
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              enableSuggestions: true,
              decoration: const InputDecoration(
                labelText: "Send Messages",
              ),
            ),
          ),
        ),
        Flexible(
          child: IconButton(
            onPressed: _submitMessage,
            icon: const Icon(Icons.send),
          ),
        ),
      ],
    );
  }
}
