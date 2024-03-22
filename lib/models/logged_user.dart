import 'package:cloud_firestore/cloud_firestore.dart';

class Address {
  String cep;
  String street;
  String city;
  String complement;
  String neighborhood;

  Address({
    required this.cep,
    required this.street,
    required this.city,
    required this.neighborhood,
    required this.complement,
  });

  factory Address.toModel(Map<String, dynamic> data) {
    return Address(
      cep: data['cep'],
      street: data['street'],
      city: data['city'],
      neighborhood: data['neighborhood'],
      complement: data['complement'],
    );
  }
}

class LoggedUser {
  String id;
  String typeProfile;
  String name;
  String email;
  String cpf;
  String? bio;
  String? avatarUrl;
  String? categoryId;
  String? categoryTitle;
  List<String>? services;
  Address? address;

  LoggedUser({
    required this.id,
    required this.typeProfile,
    required this.name,
    required this.cpf,
    required this.email,
    this.bio,
    this.avatarUrl,
    this.categoryId,
    this.categoryTitle,
    this.services,
    this.address,
  });

  factory LoggedUser.toModel(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return LoggedUser(
      id: snapshot.id,
      typeProfile: data['typeProfile'],
      name: data['name'],
      cpf: data['cpf'],
      email: data['email'],
      bio: data['bio'],
      avatarUrl: data['avatarUrl'],
      categoryId: data['categoryId'],
      services: List<String>.from(data['services'] ?? []),
      address: Address.toModel(data['address']),
    );
  }
}
