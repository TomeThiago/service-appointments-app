import 'package:app/components/card_category.dart';
import 'package:app/consts/categories.dart';
import 'package:app/screens/select_services.dart';
import 'package:flutter/material.dart';

class SelectCategory extends StatelessWidget {
  const SelectCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Selecione a Categoria',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.deepOrangeAccent,
        centerTitle: true,
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(
          height: 8.0,
        ),
        padding: const EdgeInsets.all(16.0),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SelectService(title: categories[index].title)));
            },
            child: CardCategory(
              title: categories[index].title,
              description: categories[index].description,
            ),
          );
        },
      ),
    );
  }
}
