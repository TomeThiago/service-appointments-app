import 'dart:async';

import 'package:app/components/card_nearby_professional.dart';
import 'package:app/models/category.dart';
import 'package:app/models/selected_booking.dart';
import 'package:app/models/worker.dart';
import 'package:app/repositories/booking_repository.dart';
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

class SelectWorker extends StatefulWidget {
  final Service service;
  final Category category;

  const SelectWorker(
      {super.key, required this.service, required this.category});

  @override
  State<SelectWorker> createState() => _SelectWorkerState();
}

class _SelectWorkerState extends State<SelectWorker> {
  Future<List<Worker>> fetchWorkers() async {
    List<Worker> workers =
        await UserRepository().getWorkers(widget.category, widget.service);

    return workers;
  }

  @override
  Widget build(BuildContext context) {
    var user = context.watch<AuthServiceProvider>().loggedUser;

    getDistanceBetweenClientAndWorker() {
      return 0.5;
    }

    getPrice(Worker worker) {
      double price = 0;

      worker.serviceAvailable?.forEach((service) {
        if (service.id == widget.service.id) {
          price = service.value;
        }
      });

      return price;
    }

    handleBooking(Worker worker) {
      var selectedBooking = SelectedBooking(
        worker: worker,
        category: widget.category,
        service: widget.service,
        value: getPrice(worker),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddAppointments(
            selectedBooking: selectedBooking,
          ),
        ),
      );
    }

    Future<int> getTotalBookings(String workerId) async {
      return await BookingRepository().getTotalBookingsByWorkerId(workerId);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Selecione o Serviço',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Serviço',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  widget.service.title,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4.0),
                const Text(
                  'Selecione o prestador desejado',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(101, 101, 101, 1),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12.0),
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
                      if (workers!.isEmpty) {
                        return const Center(
                            child: Text('Sem trabalhadores por perto'));
                      }

                      return ListView.builder(
                        itemCount: workers.length,
                        itemBuilder: (context, index) {
                          var worker = workers[index];

                          return CardNearbyProfessional(
                            avatarUrl: worker.avatarUrl,
                            name: worker.name,
                            totalBookings: worker.totalBookings ?? 0,
                            priceHour: getPrice(worker),
                            distance: getDistanceBetweenClientAndWorker(),
                            onPressed: () => handleBooking(worker),
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
