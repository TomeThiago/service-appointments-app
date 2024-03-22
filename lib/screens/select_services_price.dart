import 'package:app/components/button.dart';
import 'package:app/models/category.dart';
import 'package:app/repositories/user_repository.dart';
import 'package:app/service/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectServicePrice extends StatefulWidget {
  final Category category;
  final List<Service> servicesSelected;

  const SelectServicePrice({super.key, required this.servicesSelected, required this.category});

  @override
  State<SelectServicePrice> createState() => _SelectServicePriceState();
}

class _SelectServicePriceState extends State<SelectServicePrice> {
  final Map<String, double> priceAssociation = {};

  @override
  void initState() {
    super.initState();

    for (var service in widget.servicesSelected) {
      priceAssociation[service.id] = 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    var user = context.read<AuthServiceProvider>().loggedUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Selecione seus valores',
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
              'Valores',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 4.0),
            const Text(
              'Selecione os valores dos serviços',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(101, 101, 101, 1),
              ),
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: ListView.builder(
                itemCount: widget.servicesSelected.length,
                itemBuilder: (context, index) {
                  final service = widget.servicesSelected[index];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(service.title),
                      SizedBox(
                        width: 100,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              priceAssociation[service.id] = double.tryParse(value) ?? 50.0;
                            });
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Button(
                    title: 'Confirmar',
                    onPressed: () async {
                      await UserRepository().updateCategory(user!.id, widget.category.id, priceAssociation);

                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
