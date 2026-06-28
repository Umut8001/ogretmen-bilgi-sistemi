import 'package:cloud_firestore/cloud_firestore.dart';

class Getnotes {
  static Stream<QuerySnapshot> streamNotes({required String schoolCode}) {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    return _firestore
        .collection('schools')
        .doc(schoolCode)
        .collection('notes')
        .orderBy('createtime', descending: true)
        .snapshots();
  }
}
