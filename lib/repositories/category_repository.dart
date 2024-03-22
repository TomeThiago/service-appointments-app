import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/category.dart';

class CategoryRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final _tableName = "categories";

  Future<List<Category>> getCategories() async {
    QuerySnapshot querySnapshot = await _db.collection(_tableName).get();

    List<QueryDocumentSnapshot> categoriesDocuments = querySnapshot.docs;

    List<Category> listCategories = [];

    for (var document in categoriesDocuments) {
      Category category = Category.toModel(document);

      listCategories.add(category);
    }

    return listCategories;
  }

  Future<Category?> getCategoryById(String categoryId) async {
    DocumentSnapshot documentSnapshot = await _db.collection(_tableName).doc(categoryId).get();

    if(!documentSnapshot.exists) {
      return null;
    }

    Category category = Category.toModel(documentSnapshot);

    return category;
  }
}