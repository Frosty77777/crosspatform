import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/chat_message.dart';

class ChatService {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  ChatService({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  }) : _firestore = firestore ?? FirebaseFirestore.instance,
       _auth = auth ?? FirebaseAuth.instance;

  String supportChatId(String userId) => 'support_$userId';

  Stream<List<ChatMessage>> watchSupportMessages() {
    final user = _auth.currentUser;
    if (user == null) {
      return const Stream<List<ChatMessage>>.empty();
    }
    final chatId = supportChatId(user.uid);
    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .limit(50)
        .snapshots()
        .map((snapshot) => snapshot.docs.map(ChatMessage.fromDoc).toList());
  }

  Future<void> sendSupportMessage({
    required String text,
    required String senderName,
  }) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('Please sign in to send a message.');
    }
    final chatId = supportChatId(user.uid);
    final chatRef = _firestore.collection('chats').doc(chatId);
    await chatRef.set({
      'chatId': chatId,
      'userId': user.uid,
      'userEmail': user.email,
      'updatedAt': FieldValue.serverTimestamp(),
      'type': 'support',
    }, SetOptions(merge: true));

    await chatRef.collection('messages').add({
      'senderId': user.uid,
      'senderName': senderName,
      'text': text,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}
