import 'package:cloud_firestore/cloud_firestore.dart';

class Duyuru {
  final String id;
  final String title;
  final String body;
  final String gorsel;
  final DateTime createtime;
  final DateTime updatetime;

  Duyuru({
    required this.id,
    required this.title,
    required this.body,
    required this.gorsel,
    required this.createtime,
    required this.updatetime,
  });

  factory Duyuru.fromMap(Map<String, dynamic> map, String documentId) {
    DateTime _convertTimestampToDateTime(dynamic timestampData) {
      if (timestampData is Timestamp) {
        return timestampData.toDate();
      }

      return DateTime.now();
    }

    return Duyuru(
      id: documentId,
      title: map['title'] as String? ?? '',
      body: map['body'] as String? ?? '',
      gorsel: map['gorsel'] as String? ?? '',

      createtime: _convertTimestampToDateTime(map['createtime']),
      updatetime: _convertTimestampToDateTime(map['updatetime']),
    );
  }

  @override
  String toString() {
    return 'Duyuru: $title - $body';
  }
}
