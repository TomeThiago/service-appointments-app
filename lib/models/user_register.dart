import 'package:cloud_firestore/cloud_firestore.dart';

class UserAddressRegister {
  String cep;
  String street;
  String neighborhood;
  String city;
  String? complement;

  UserAddressRegister({
    required this.cep,
    required this.street,
    required this.neighborhood,
    required this.city,
    this.complement,
  });
}

class User {
  String? id;
  String typeProfile;
  String name;
  String email;
  String cpf;
  String password;
  String? avatarUrl;
  UserAddressRegister? address;

  User({
    this.id,
    required this.typeProfile,
    required this.name,
    required this.cpf,
    required this.email,
    required this.password,
    this.address,
    this.avatarUrl,
  });

  factory User.toModel(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return User(
      id: snapshot.id,
      name: data['name'],
      cpf: data['cpf'],
      email: data['email'],
      password: '',
      typeProfile: data['typeProfile'],
      avatarUrl: data['avatarUrl'],
    );
  }
}
