import 'package:app/components/button.dart';
import 'package:app/models/user_register.dart';
import 'package:app/screens/home.dart';
import 'package:app/screens/select_category.dart';
import 'package:app/screens/sign_in.dart';
import 'package:app/service/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class AddressRegister extends StatefulWidget {
  final User user;

  const AddressRegister({
    super.key,
    required this.user,
  });

  @override
  State<AddressRegister> createState() => _AddressRegisterState();
}

class _AddressRegisterState extends State<AddressRegister> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController cepController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController neighbourhoodController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController complementController = TextEditingController();

  void handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      var userAddress = UserAddressRegister(
        cep: cepController.text,
        street: addressController.text,
        neighborhood: neighbourhoodController.text,
        city: cityController.text,
        complement: complementController.text,
      );

      widget.user.address = userAddress;

      debugPrint(widget.user.typeProfile);
      debugPrint(widget.user.name);
      debugPrint(widget.user.cpf);
      debugPrint(widget.user.address?.street);
      debugPrint(widget.user.address?.neighborhood);

      AuthService authService = AuthService();

      try {
        await authService.signUp(widget.user.email, widget.user.password);

        if(widget.user.typeProfile == 'client') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Home(),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SelectCategory(),
            ),
          );
        }
      } on firebase_auth.FirebaseAuthException catch (e) {
        String message = 'Ocorreu um erro inesperado. Por favor, tente novamente.';

        if (e.code == 'weak-password') {
          message = 'A senha é muito fraca, por favor tente uma senha mais forte';
        } else if (e.code == 'email-already-in-use') {
          message = 'Já existe uma conta com este e-mail se a conta for sua tente fazer o login';
        }

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Erro ao criar o usuário'),
              content: Text(message),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Erro ao criar o usuário'),
              content: const Text('Ocorreu um erro inesperado. Por favor, tente novamente mais tarde.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                'assets/images/logo.jpg',
                height: 146.0,
                width: 146.0,
              ),
              const SizedBox(
                height: 16.0,
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Criar Conta',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    'Boas-vindas ao S.O.S Cleaning',
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.deepOrangeAccent),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    'Já estamos concluindo, só precisamos de mais algumas informações.',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    'Demora uns 2 minutinhos',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.deepOrange,
                    ),
                  ),
                ],
              ),
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
                          hintText: 'Digite a sua cidade',
                        ),
                      ),
                      const SizedBox(
                        height: 32.0,
                      ),
                      Button(
                        title: 'Cadastrar',
                        onPressed: handleSubmit,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Já tem uma conta?',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SignIn()));
                            },
                            child: const Text(
                              'Fazer Login',
                              style: TextStyle(
                                color: Colors.deepOrange,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
