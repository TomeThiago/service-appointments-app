import 'package:cloud_firestore/cloud_firestore.dart';

class Service {
  String id;
  String title;

  Service({
    required this.id,
    required this.title,
  });

  factory Service.toModel(Map<String, dynamic> data) {
    return Service(
      id: data["id"],
      title: data["title"],
    );
  }
}

class Category {
  String id;
  String title;
  String description;
  String imageUrl;
  List<Service>? services;

  Category({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    this.services,
  });

  factory Category.toModel(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    List<Service>? servicesList;

    if (data.containsKey("services")) {
      List<dynamic> servicesData = data["services"];

      servicesList = servicesData.map((serviceData) => Service.toModel(serviceData)).toList();
    }

    return Category(
      id: snapshot.id,
      title: data["title"],
      description: data["description"],
      imageUrl: data["imageUrl"],
      services: servicesList,
    );
  }
}
