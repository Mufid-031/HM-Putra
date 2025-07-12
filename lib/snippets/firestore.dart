import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreSnippets {
  final FirebaseFirestore db;

  FirestoreSnippets(this.db);

  Future<List<Map<String, dynamic>>> readUsers() async {
    final snapshot = await db.collection('users').get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }
}
