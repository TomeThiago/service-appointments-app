import 'package:app/components/appointment_card.dart';
import 'package:app/consts/profile.dart';
import 'package:app/models/booking.dart';
import 'package:app/models/category.dart';
import 'package:app/models/logged_user.dart';
import 'package:app/repositories/booking_repository.dart';
import 'package:app/service/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum FilterStatus { upcoming, complete, cancel }

class Appointments extends StatefulWidget {
  const Appointments({super.key});

  @override
  State<Appointments> createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  FilterStatus status = FilterStatus.upcoming;
  Alignment _alignment = Alignment.centerLeft;

  Map<FilterStatus, String> filterNames = {
    FilterStatus.upcoming: 'Próximos',
    FilterStatus.complete: 'Completos',
    FilterStatus.cancel: 'Cancelados',
  };

  Future<List<Booking>> fetchBooking(LoggedUser user) async {
    List<Booking> bookings = [];

    String statusQuery = 'Pendente';

    if (filterNames[status] == 'Completos') {
      statusQuery = 'Finalizado';
    } else if (filterNames[status] == 'Cancelados') {
      statusQuery = 'Cancelado';
    }

    if(user.typeProfile == 'worker') {
      bookings = await BookingRepository().getBookingsByWorkerId(statusQuery, user.id);
    } else {
      bookings = await BookingRepository().getBookingsByUserId(statusQuery, user.id);
    }

    return bookings;
  }

  String getServiceTitle(List<Service>? services, String serviceId) {
    String title = '';

    if(services!.isEmpty) {
      return title;
    }

    for (var service in services) {
      if(service.id == serviceId) {
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

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Agendamentos',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.deepOrangeAccent,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //this is the filter tabs
                      for (FilterStatus filterStatus in FilterStatus.values)
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (filterStatus == FilterStatus.upcoming) {
                                  status = FilterStatus.upcoming;
                                  _alignment = Alignment.centerLeft;
                                } else if (filterStatus ==
                                    FilterStatus.complete) {
                                  status = FilterStatus.complete;
                                  _alignment = Alignment.center;
                                } else if (filterStatus ==
                                    FilterStatus.cancel) {
                                  status = FilterStatus.cancel;
                                  _alignment = Alignment.centerRight;
                                }
                              });
                            },
                            child: Center(
                              child: Text(filterNames[filterStatus]!),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                AnimatedAlign(
                  alignment: _alignment,
                  duration: const Duration(milliseconds: 200),
                  child: Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.deepOrangeAccent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        filterNames[status]!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: FutureBuilder<List<Booking>>(
                future: fetchBooking(user!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Erro: ${snapshot.error}'));
                  } else {
                    List<Booking>? bookings = snapshot.data;

                    if(bookings!.isEmpty) {
                      return Center(child: Text('Sem agendamentos ${filterNames[status]!.toLowerCase()}'));
                    }

                    return ListView.builder(
                      itemCount: bookings.length,
                      itemBuilder: (context, index) {
                        Booking booking = bookings[index];
                        return AppointmentCard(
                          id: booking.id ?? '',
                          name: user.typeProfile == 'worker' ? booking.user!.name : booking.worker!.name,
                          photoUrl: user.typeProfile == 'worker' ? booking.user!.avatarUrl ?? ProfileConst.avatarUrl : booking.worker!.avatarUrl ?? ProfileConst.avatarUrl,
                          service: getServiceTitle(booking.category!.services, booking.serviceId),
                          date: formatDate(booking.data),
                          hour: formatHour(booking.data),
                          address: booking.address,
                          status: booking.status,
                          typePayment: booking.typePayment,
                          price: booking.value,
                          onConfirm: () async {
                            await BookingRepository().updateStatus(booking.id ?? '', 'Finalizado');

                            setState(() {});
                          },
                          onCancel: () async {
                            await BookingRepository().updateStatus(booking.id ?? '', 'Cancelado');

                            setState(() {});
                          },
                        );
                      },
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
