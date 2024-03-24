import 'package:app/components/button.dart';
import 'package:app/screens/select_services_price.dart';
import 'package:flutter/material.dart';
import 'package:app/models/category.dart';

class SelectService extends StatefulWidget {
  final Category category;
  final bool? isFirstAccess;

  const SelectService({super.key, required this.category, this.isFirstAccess = false});

  @override
  State<SelectService> createState() => _SelectServiceState();
}

class _SelectServiceState extends State<SelectService> {
  late List<bool> checked;

  @override
  void initState() {
    super.initState();
    checked = List<bool>.filled(widget.category.services!.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Selecione seus Serviços',
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
              'Selecione os serviços prestados',
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
                      setState(() {
                        checked[index] = !checked[index];
                      });
                    },
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      margin: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 4.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [
                            Checkbox(
                              value: checked[index],
                              onChanged: (bool? value) {
                                setState(() {
                                  checked[index] = value!;
                                });
                              },
                            ),
                            Text(
                              service.title,
                              style: const TextStyle(fontSize: 16.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Button(
                    title: 'Próximo',
                    onPressed: () async {
                      List<Service> servicesSelected = [];

                      checked.asMap().forEach((index, value) {
                        if (value) {
                          servicesSelected.add(widget.category.services![index]);
                        }
                      });

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SelectServicePrice(
                            category: widget.category,
                            servicesSelected: servicesSelected,
                          ),
                        ),
                      );
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
