import 'package:flutter/material.dart';
import '../models/dummy_data.dart';
import 'models_screen.dart';

class BrandsScreen extends StatelessWidget {
  final Category category;

  const BrandsScreen({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category.nameAr),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: phoneBrands.length,
        itemBuilder: (context, index) {
          final brand = phoneBrands[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue[100],
                child: Text(
                  brand.logoIcon,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text(
                brand.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ModelsScreen(
                      category: category,
                      brand: brand,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
