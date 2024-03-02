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
  String typeProfile;
  String name;
  String email;
  String cpf;
  String password;
  UserAddressRegister? address;

  User({
    required this.typeProfile,
    required this.name,
    required this.cpf,
    required this.email,
    required this.password,
    this.address,
  });
}
