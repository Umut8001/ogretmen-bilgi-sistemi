import 'package:cloud_firestore/cloud_firestore.dart';

class Getogrinfo {
  static Stream<QuerySnapshot> streamStudents({required String schoolCode}) {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    return _firestore
        .collection('schools')
        .doc(schoolCode)
        .collection('students')
        .snapshots();
  }
}
