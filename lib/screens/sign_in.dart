import 'package:app/components/button.dart';
import 'package:app/screens/home.dart';
import 'package:app/screens/select_profile.dart';
import 'package:app/service/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _obscureText = true;

  handleLogin(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      var authService = AuthService();

      String email = emailController.text;
      String password = passwordController.text;

      try {
        var user = await authService.signIn(email, password);

        if (user != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Home(),
            ),
          );
        }
      } catch (error) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Erro de Login'),
              content: const Text('Usuário ou senha incorretos. Por favor, tente novamente.'),
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
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.jpg',
                height: 146.0,
                width: 146.0,
              ),
              const SizedBox(
                height: 16.0,
              ),
              const Text(
                'Entre na plataforma',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24.0,
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (String? value) {
                        if (value != null && value.isEmpty) {
                          return 'Insira o e-mail de login';
                        }

                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'E-mail',
                        hintText: 'Digite o seu e-mail',
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: _obscureText,
                      validator: (String? value) {
                        if (value != null && value.isEmpty) {
                          return 'Insira a senha de login';
                        }

                        return null;
                      },
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
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Button(
                    title: 'Entrar',
                    onPressed: () => handleLogin(context),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Não tem uma conta?',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SelectProfile()));
                        },
                        child: const Text(
                          'Criar conta',
                          style: TextStyle(
                            color: Colors.deepOrange,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
