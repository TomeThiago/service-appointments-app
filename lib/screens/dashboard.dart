import 'package:app/components/next_booking.dart';
import 'package:app/consts/profile.dart';
import 'package:app/models/booking.dart';
import 'package:app/models/category.dart';
import 'package:app/models/data.dart';
import 'package:app/models/logged_user.dart';
import 'package:app/repositories/booking_repository.dart';
import 'package:app/repositories/category_repository.dart';
import 'package:app/screens/filter_service.dart';
import 'package:app/screens/sign_in.dart';
import 'package:app/utils/numbers.dart';
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

  Future<Booking?> fetchNextBooking(String userId, String typeProfile) async {
    List<Booking> bookings = [];

    if (typeProfile == 'worker') {
      bookings =
          await BookingRepository().getBookingsByWorkerId('Pendente', userId);
    } else {
      bookings =
          await BookingRepository().getBookingsByUserId('Pendente', userId);
    }

    return bookings.isNotEmpty ? bookings[0] : null;
  }

  Future<Data> fetchData(
    String userId,
  ) async {
    int totalBookings =
        await BookingRepository().getTotalBookingsByWorkerId(userId);

    List<Booking> bookings =
        await BookingRepository().getBookingsByWorkerId('Finalizado', userId);

    double totalValue = 0.0;

    for (var element in bookings) {
      totalValue += element.value;
    }

    return Data(
      total: totalValue,
      totalBookings: totalBookings,
    );
  }

  String getServiceTitle(List<Service>? services, String serviceId) {
    String title = '';

    if (services!.isEmpty) {
      return title;
    }

    for (var service in services) {
      if (service.id == serviceId) {
        title = service.title;
      }
    }

    return title;
  }

  String formatDate(String data) {
    DateTime dateTime = DateTime.parse(data);

    return '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year.toString()}';
  }

  String formatHour(String data) {
    DateTime dateTime = DateTime.parse(data);

    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    var user = context.watch<AuthServiceProvider>().loggedUser;

    String formatAddress(LoggedUser user) {
      if (user.address?.complement != null &&
          user.address!.complement.isNotEmpty) {
        return '${user.address?.street} - ${user.address?.complement}, ${user.address?.neighborhood}, ${user.address?.cep}';
      }

      return '${user.address?.street}, ${user.address?.neighborhood}, ${user.address?.cep}';
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
              formatAddress(user!),
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  user.typeProfile == 'worker'
                      ? 'Próximo serviço'
                      : 'Próximo agendamento',
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8.0,
            ),
            FutureBuilder<Booking?>(
              future: fetchNextBooking(user.id, user.typeProfile),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Erro: ${snapshot.error}'));
                } else {
                  Booking? bookingData = snapshot.data;

                  if (bookingData == null) {
                    return const Text('Nenhum agendamento');
                  }

                  return NextBookingCard(
                    id: bookingData.id ?? '',
                    name: user.typeProfile == 'worker'
                        ? bookingData.user!.name
                        : bookingData.worker!.name,
                    photoUrl: user.typeProfile == 'worker'
                        ? bookingData.user!.avatarUrl ?? ProfileConst.avatarUrl
                        : bookingData.worker!.avatarUrl ??
                            ProfileConst.avatarUrl,
                    service: getServiceTitle(
                        bookingData.category!.services, bookingData.serviceId),
                    date: formatDate(bookingData.data),
                    hour: formatHour(bookingData.data),
                    address: bookingData.address,
                    status: bookingData.status,
                    typePayment: bookingData.typePayment,
                    price: bookingData.value,
                  );
                }
              },
            ),
            const SizedBox(
              height: 16.0,
            ),
            Visibility(
              visible: user.typeProfile != 'worker',
              child: const Text(
                'Categorias',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Visibility(
              visible: user.typeProfile != 'worker',
              child: Expanded(
                flex: 2,
                child: FutureBuilder<List<Category>>(
                  future: fetchCategories(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Erro: ${snapshot.error}'));
                    } else {
                      List<Category>? categories = snapshot.data;
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                        ),
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
            ),
            Visibility(
              visible: user.typeProfile == 'worker',
              child: FutureBuilder<Data>(
                future: fetchData(user.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Erro: ${snapshot.error}'));
                  } else {
                    Data? data = snapshot.data;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Informações',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Card(
                          elevation: 4,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  const Text(
                                    'Número de serviços realizados',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  Text(
                                    data!.totalBookings.toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 36.0,
                                      color: Colors.deepOrange,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Card(
                          elevation: 4,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  const Text(
                                    'Total arrecadado pelo aplicativo',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  Text(
                                    'R\$ ${formatMoney(data.total)}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 36.0,
                                      color: Colors.deepOrange,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
