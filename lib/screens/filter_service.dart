import 'package:app/components/button.dart';
import 'package:app/models/worker.dart';
import 'package:app/repositories/user_repository.dart';
import 'package:app/screens/dashboard.dart';
import 'package:app/screens/home.dart';
import 'package:app/screens/profile.dart';
import 'package:app/screens/select_services_price.dart';
import 'package:app/screens/select_worker.dart';
import 'package:app/service/auth.dart';
import 'package:flutter/material.dart';
import 'package:app/models/category.dart';
import 'package:provider/provider.dart';

class FilterService extends StatefulWidget {
  final Category category;

  const FilterService({super.key, required this.category});

  @override
  State<FilterService> createState() => _FilterServiceState();
}

class _FilterServiceState extends State<FilterService> {
  @override
  Widget build(BuildContext context) {
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
            const Text(
              'Categoria',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              widget.category.title,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4.0),
            const Text(
              'Selecione o serviço desejado',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(101, 101, 101, 1),
              ),
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: ListView.builder(
                itemCount: widget.category.services!.length,
                itemBuilder: (context, index) {
                  final service = widget.category.services![index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SelectWorker(
                            category: widget.category,
                            service: service,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 4,
                      color: Colors.white,
                      surfaceTintColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      margin: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 0),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 4.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          child: Row(
                            children: [
                              Text(
                                service.title,
                                style: const TextStyle(fontSize: 16.0),
                              ),
                            ],
                          ),
                        ),
                      )
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
