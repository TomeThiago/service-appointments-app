import 'package:app/components/button.dart';
import 'package:app/models/logged_user.dart';
import 'package:app/repositories/user_repository.dart';
import 'package:app/service/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditAddress extends StatefulWidget {
  const EditAddress({
    super.key,
  });

  @override
  State<EditAddress> createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var authProvider = context.watch<AuthServiceProvider>();
    var user = authProvider.loggedUser;

    TextEditingController cepController = TextEditingController(
        text: user?.address?.cep
    );
    TextEditingController addressController = TextEditingController(
        text: user?.address?.street
    );
    TextEditingController neighbourhoodController = TextEditingController(
        text: user?.address?.neighborhood
    );
    TextEditingController cityController = TextEditingController(
        text: user?.address?.city
    );
    TextEditingController complementController = TextEditingController(
        text: user?.address?.complement
    );

    void handleSubmit() async {
      Address address = Address(
          cep: cepController.text,
          street: addressController.text,
          city: cityController.text,
          neighborhood: neighbourhoodController.text,
          complement: complementController.text,
      );

      await UserRepository().updateAddress(user!.id, address);

      user.address = address;

      Navigator.pop(context);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Editar Endereço',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.deepOrangeAccent,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: cepController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'CEP',
                          hintText: 'Digite o seu CEP',
                        ),
                        validator: (String? value) {
                          if (value != null && value.isEmpty) {
                            return 'Insira o CEP para o cadastro';
                          }

                          return null;
                        },
                      ),
                      TextFormField(
                        controller: addressController,
                        decoration: const InputDecoration(
                          labelText: 'Endereço',
                          hintText: 'Digite o seu endereço',
                        ),
                        validator: (String? value) {
                          if (value != null && value.isEmpty) {
                            return 'Insira o endereço para o cadastro';
                          }

                          return null;
                        },
                      ),
                      TextFormField(
                        controller: neighbourhoodController,
                        decoration: const InputDecoration(
                          labelText: 'Bairro',
                          hintText: 'Digite o seu bairro',
                        ),
                        validator: (String? value) {
                          if (value != null && value.isEmpty) {
                            return 'Insira o bairro para o cadastro';
                          }

                          return null;
                        },
                      ),
                      TextFormField(
                        controller: cityController,
                        decoration: const InputDecoration(
                          labelText: 'Cidade',
                          hintText: 'Digite a sua cidade',
                        ),
                        validator: (String? value) {
                          if (value != null && value.isEmpty) {
                            return 'Insira a cidade para o cadastro';
                          }

                          return null;
                        },
                      ),
                      TextFormField(
                        controller: complementController,
                        decoration: const InputDecoration(
                          labelText: 'Complemento (opcional)',
                          hintText: 'Digite o complemento do endereço',
                        ),
                      ),
                      const SizedBox(
                        height: 32.0,
                      ),
                      Button(
                        title: 'Confirmar',
                        onPressed: handleSubmit,
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
