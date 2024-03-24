import 'package:app/components/button_outline.dart';
import 'package:app/screens/sign_in.dart';
import 'package:app/screens/user_register.dart';
import 'package:flutter/material.dart';

class SelectProfile extends StatelessWidget {
  const SelectProfile({super.key});

  void handleSelectProfile(BuildContext context, String profile) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserRegister(
          profile: profile,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
                  'É muito bom te ter conosco. Para iniciarmos, informe o que você busca.',
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
                    fontWeight: FontWeight.w300,
                    color: Colors.deepOrange,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 32.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ButtonOutline(
                  title: 'Busco um serviço',
                  onPressed: () => handleSelectProfile(context, 'worker'),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                ButtonOutline(
                  title: 'Busco um profissional',
                  onPressed: () => handleSelectProfile(context, 'client'),
                ),
                const SizedBox(
                  height: 16.0,
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
            )
          ],
        ),
      ),
    );
  }
}
