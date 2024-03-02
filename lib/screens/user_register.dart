import 'package:app/components/button.dart';
import 'package:app/models/user_register.dart' ;
import 'package:app/screens/address_register.dart';
import 'package:app/screens/sign_in.dart';
import 'package:flutter/material.dart';

class UserRegister extends StatefulWidget {
  final String profile;

  const UserRegister({
    super.key,
    required this.profile,
  });

  @override
  State<UserRegister> createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  final _formKey = GlobalKey<FormState>();

  bool _obscureText = true;

  TextEditingController nameController = TextEditingController();
  TextEditingController cpfController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      var user = User(
        typeProfile: widget.profile,
        name: nameController.text,
        cpf: cpfController.text,
        email: emailController.text,
        password: passwordController.text,
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddressRegister(
            user: user,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
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
                  height: 32.0,
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
                  'OK! Agora precisamos dos seus dados pessoais para criar o seu perfil',
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
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Nome',
                      hintText: 'Digite o seu nome completo',
                    ),
                    validator: (String? value) {
                      if (value != null && value.isEmpty) {
                        return 'Insira a nome para o cadastro';
                      }

                      return null;
                    },
                  ),
                  TextFormField(
                    controller: cpfController,
                    decoration: const InputDecoration(
                      labelText: 'CPF',
                      hintText: 'Digite o seu CPF',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (String? value) {
                      if (value != null && value.isEmpty) {
                        return 'Insira o cpf para o cadastro';
                      }

                      return null;
                    },
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: 'E-mail',
                      hintText: 'Digite o seu e-mail',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (String? value) {
                      if (value != null && value.isEmpty) {
                        return 'Insira o e-mail para o cadastro';
                      }

                      return null;
                    },
                  ),
                  TextFormField(
                    controller: passwordController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      hintText: 'Digite a sua senha',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ),
                    validator: (String? value) {
                      if (value != null && value.isEmpty) {
                        return 'Insira a senha para o cadastro';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 32.0,
                  ),
                  Button(
                    title: 'Continuar',
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
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
