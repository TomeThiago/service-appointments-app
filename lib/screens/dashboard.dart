import 'package:app/components/card_nearby_professional.dart';
import 'package:app/models/category.dart';
import 'package:app/models/worker.dart';
import 'package:app/repositories/category_repository.dart';
import 'package:app/repositories/user_repository.dart';
import 'package:app/screens/add_appointments.dart';
import 'package:app/screens/filter_service.dart';
import 'package:app/screens/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:app/components/category_option.dart';
import 'package:app/components/header_home.dart';
import 'package:app/service/auth.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String formatTitleCategory(String value) {
    return value.replaceAll(' ', '\n');
  }

  void handleSignOut(BuildContext context) {
    var authProvider = context.watch<AuthServiceProvider>();

    authProvider.signOut();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignIn(),
      ),
    );
  }

  Future<List<Category>> fetchCategories() async {
    var categories = await CategoryRepository().getCategories();

    return categories;
  }

  Future<List<Worker>> fetchWorkers() async {
    //List<Worker> workers = await UserRepository().getWorkers(null, null);

    //return workers;

    return [];
  }

  @override
  Widget build(BuildContext context) {
    var user = context.watch<AuthServiceProvider>().loggedUser;

    handleBooking() {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => const AddAppointments(),
      //   ),
      // );
    }

    getDistanceBetweenClientAndWorker() {
      return 0.5;
    }

    return Scaffold(
      appBar: const HeaderHome(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Localização',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '${user?.address?.street} , ${user?.address?.city}',
              style: const TextStyle(
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
            Expanded(
              child: FutureBuilder<List<Category>>(
                future: fetchCategories(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Erro: ${snapshot.error}'));
                  } else {
                    List<Category>? categories = snapshot.data;
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories!.length,
                      itemBuilder: (context, index) {
                        Category category = categories[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FilterService(
                                  category: category,
                                ),
                              ),
                            );
                          },
                          child: CategoryOption(
                            title: category.title,
                            imageUrl: category.imageUrl,
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Perto de você',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    print('clicou');
                  },
                  icon: const Icon(Icons.filter_alt_outlined),
                ),
              ],
            ),
            Expanded(
                flex: 5,
                child: FutureBuilder<List<Worker>>(
                  future: fetchWorkers(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Erro: ${snapshot.error}'));
                    } else {
                      List<Worker>? workers = snapshot.data;
                      if(workers!.isEmpty) {
                        return const Center(child: Text('Sem trabalhadores por perto'));
                      }

                      return ListView.builder(
                        itemCount: workers.length,
                        itemBuilder: (context, index) {
                          var worker = workers[index];

                          return CardNearbyProfessional(
                            avatarUrl: worker.avatarUrl,
                            name: worker.name,
                            totalBookings: 123,
                            priceHour: 55.0,
                            distance: getDistanceBetweenClientAndWorker(),
                            onPressed: handleBooking,
                          );
                        },
                      );
                    }
                  },
                )),
          ],
        ),
      ),
    );
  }
}
