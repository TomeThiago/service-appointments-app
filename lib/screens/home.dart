import 'package:app/service/auth.dart';
import 'package:flutter/material.dart';
import 'package:app/components/card_nearby_professional.dart';
import 'package:app/consts/categories.dart';
import 'package:app/screens/sign_in.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  String formatTitleCategory(String value) {
    return value.replaceAll(' ', '\n');
  }

  void handleSignOut(BuildContext context) {
    var authService = AuthService();

    authService.signOut();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignIn(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                      radius: 24,
                    ),
                    SizedBox(
                      width: 16.0,
                    ),
                    Text(
                      'Olá, Emily',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(
                    Icons.exit_to_app,
                    size: 32.0,
                  ),
                  onPressed: () => handleSignOut(context),
                ),
              ],
            ),
            const SizedBox(
              height: 16.0,
            ),
            const SizedBox(
              height: 45.0,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Procurar',
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
          ],
        ),
        toolbarHeight: 135.0,
        backgroundColor: Colors.deepOrangeAccent,
        automaticallyImplyLeading: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
        leading: null,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Localização atual',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Text(
              'Av. Rui Barbosa, Piracicaba - SP',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            const Text(
              'Categorias',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 130,
              child: ListView.separated(
                separatorBuilder: (context, index) =>
                    const SizedBox(width: 16.0),
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                          child: Image.network(
                            'https://img.icons8.com/external-vitaliy-gorbachev-flat-vitaly-gorbachev/2x/external-cleaning-labour-day-vitaliy-gorbachev-flat-vitaly-gorbachev.png',
                            width: 50,
                            height: 50,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          textAlign: TextAlign.center,
                          formatTitleCategory(categories[index].title),
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Text(
              'Profissionais Próximos',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            CardNearbyProfessional(
              name: 'Maria dos Santos',
              position: 'Diarista',
              totalBookings: 104,
              priceHour: 50.0,
              distance: 1.5,
            ),
            CardNearbyProfessional(
              name: 'Ana dos Santos',
              position: 'Faxineira',
              totalBookings: 103,
              priceHour: 35.0,
              distance: 1.4,
            )
          ],
        ),
      ),
    );
  }
}
