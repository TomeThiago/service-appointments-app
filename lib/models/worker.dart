import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceAvailable {
  String id;
  double value;

  ServiceAvailable({
    required this.id,
    required this.value,
  });

  factory ServiceAvailable.toModel(Map<String, dynamic> data) {
    return ServiceAvailable(
      id: data['id'],
      value: data['value']
    );
  }
}

class Worker {
  String id;
  String name;
  String? avatarUrl;
  String? categoryId;
  String? categoryTitle;
  String? address;
  int? totalBookings;
  double? distance;
  List<ServiceAvailable>? serviceAvailable;

  Worker({
    required this.id,
    required this.name,
    this.avatarUrl,
    this.categoryId,
    this.categoryTitle,
    this.address,
    this.distance,
    this.serviceAvailable,
  });

  factory Worker.toModel(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    String address = data["address"]["street"] + ', ' + data["address"]["complement"] + ' - ' + data["address"]["neighborhood"] + ', ' + data["address"]["city"] + ' - ' + data["address"]["cep"];

    List<dynamic> servicesData = data['services'] ?? [];

    List<ServiceAvailable> services = [];

    for (var serviceData in servicesData) {
      services.add(ServiceAvailable.toModel(serviceData));
    }

    return Worker(
      id: snapshot.id,
      name: data['name'],
      avatarUrl: data['avatarUrl'],
      categoryId: data['categoryId'],
      categoryTitle: data['categoryTitle'],
      address: address,
      serviceAvailable: services,
    );
  }
}
