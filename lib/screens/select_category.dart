import 'package:app/components/card_category.dart';
import 'package:app/models/category.dart';
import 'package:app/repositories/category_repository.dart';
import 'package:app/screens/select_services.dart';
import 'package:flutter/material.dart';

class SelectCategory extends StatefulWidget {
  final bool? isFirstAccess;

  const SelectCategory({super.key, this.isFirstAccess = false});

  @override
  State<SelectCategory> createState() => _SelectCategoryState();
}

class _SelectCategoryState extends State<SelectCategory> {
  Future<List<Category>> fetchCategories() async {
    var categories = await CategoryRepository().getCategories();

    return categories;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Selecione a Categoria',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.deepOrangeAccent,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
                itemCount: categories!.length,
                itemBuilder: (context, index) {
                  Category category = categories[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SelectService(
                            category: categories[index],
                          ),
                        ),
                      );
                    },
                    child: CardCategory(
                      title: category.title,
                      description: category.description,
                    ),
                  );
                },
              );
            }
          },
        ),
      )
    );
  }
}
