import 'package:app/components/button.dart';
import 'package:app/screens/select_profile.dart';
import 'package:app/screens/sign_in.dart';
import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset('assets/images/logo.jpg'),
            const Column(
              children: [
                Text(
                  'Seu app para \n serviços gerais',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.deepOrange,
                    fontWeight: FontWeight.w700,
                    fontSize: 32.0,
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  'Seu aplicativo para procurar profissionais ou clientes tudo em um só lugar e direto na palma da sua mão.',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Button(
                  title: 'Fazer Login',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignIn(),
                      ),
                    );
                  },
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SelectProfile()));
                  },
                  child: const Text(
                    'Criar uma conta',
                    style: TextStyle(
                        color: Colors.black,
                        decoration: TextDecoration.underline),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
