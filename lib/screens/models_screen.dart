import 'package:flutter/material.dart';
import '../models/dummy_data.dart';
import 'compatibility_screen.dart';

class ModelsScreen extends StatefulWidget {
  final Category category;
  final Brand brand;

  const ModelsScreen({
    Key? key,
    required this.category,
    required this.brand,
  }) : super(key: key);

  @override
  State<ModelsScreen> createState() => _ModelsScreenState();
}

class _ModelsScreenState extends State<ModelsScreen> {
  late List<PhoneModel> _allModels;
  late List<PhoneModel> _filteredModels;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _allModels = phoneModels
        .where((m) => m.brandId == widget.brand.id)
        .toList();
    _filteredModels = List.from(_allModels);
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = _searchController.text.trim().toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredModels = List.from(_allModels);
      } else {
        _filteredModels = _allModels.where((m) {
          return m.name.toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.brand.name} - ${widget.category.nameAr}'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'ابحث عن موديل الهاتف...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 16,
                ),
              ),
            ),
          ),
          Expanded(
            child: _filteredModels.isEmpty
                ? const Center(
                    child: Text(
                      'لا توجد موديلات مطابقة لبحثك.',
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    itemCount: _filteredModels.length,
                    itemBuilder: (context, index) {
                      final model = _filteredModels[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          leading: const Icon(Icons.smartphone),
                          title: Text(
                            model.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CompatibilityScreen(
                                  category: widget.category,
                                  brand: widget.brand,
                                  model: model,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
