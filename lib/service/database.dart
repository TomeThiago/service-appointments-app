import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<dynamic> insertData(String collectionName, dynamic data) async {
    return _db.collection(collectionName).add(data);
  }
}