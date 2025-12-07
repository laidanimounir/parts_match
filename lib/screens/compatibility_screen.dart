import 'package:flutter/material.dart';
import '../models/dummy_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CompatibilityScreen extends StatefulWidget {
  final Category category;
  final Brand brand;
  final PhoneModel model;

  const CompatibilityScreen({
    Key? key,
    required this.category,
    required this.brand,
    required this.model,
  }) : super(key: key);

  @override
  State<CompatibilityScreen> createState() => _CompatibilityScreenState();
}

class _CompatibilityScreenState extends State<CompatibilityScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    final initialIndex = widget.category.id == '1' ? 0 : 1;
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: initialIndex,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<List<Compatibility>> _fetchCompatibilitiesFromApi(String type) async {
    final url = 'http://192.168.1.5/parts_match_backend/api/compatibilities.php'
        '?phone_model_id=${widget.model.id}&type=$type';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);

        return jsonData.map((item) {
          return Compatibility(
            id: item['id'],
            phoneModelId: item['phoneModelId'],
            type: item['type'],
            compatibleWith: item['compatibleWith'],
            notes: item['notes'],
          );
        }).toList();
      } else {
        return [];
      }
    } catch (e) {
      print('Error fetching data: $e');
      return [];
    }
  }

  void _showReportDialog(BuildContext context, Compatibility item) {
    final TextEditingController noteController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.report_problem, color: Colors.orange[700]),
            const SizedBox(width: 8),
            const Text('تصحيح معلومة'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'هل تواجه مشكلة مع توافق "${item.compatibleWith}"؟',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text('أخبرنا عن تجربتك (مثلاً: لا تعمل، الصورة مقلوبة...):'),
            const SizedBox(height: 8),
            TextField(
              controller: noteController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'اكتب ملاحظتك هنا...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.grey[50],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('إلغاء', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange[700],
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('شكراً لك! سيتم مراجعة تقريرك لتحديث البيانات.'),
                  backgroundColor: Colors.green,
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: const Text('إرسال التقرير'),
          ),
        ],
      ),
    );
  }

  List<Compatibility> _getCompatibilities(String type) {
    return compatibilities
        .where((c) =>
            c.phoneModelId == widget.model.id &&
            c.type == type)
        .toList();
  }

  Widget _buildList(String type) {
  return FutureBuilder<List<Compatibility>>(
    future: _fetchCompatibilitiesFromApi(type),
    builder: (context, snapshot) {
     
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }

      
      if (snapshot.hasError) {
        return Center(
          child: Text('حدث خطأ: ${snapshot.error}'),
        );
      }

      final list = snapshot.data ?? [];

      if (list.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                type == 'screen' ? Icons.mobile_off : Icons.shield_outlined,
                size: 64,
                color: Colors.grey[300],
              ),
              const SizedBox(height: 16),
              Text(
                type == 'screen'
                    ? 'لا توجد شاشات متوافقة مسجلة.'
                    : 'لا يوجد Glass حماية مسجل.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        );
      }

      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: list.length,
        itemBuilder: (context, index) {
          final item = list[index];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: type == 'screen'
                      ? Colors.blue[50]
                      : Colors.green[50],
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  type == 'screen' ? Icons.phone_android : Icons.shield,
                  color: type == 'screen' ? Colors.blue : Colors.green,
                ),
              ),
              title: Text(
                item.compatibleWith,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(
                    item.notes,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.flag_outlined,
                  color: Colors.orange[300],
                ),
                tooltip: 'إبلاغ عن خطأ',
                onPressed: () => _showReportDialog(context, item),
              ),
            ),
          );
        },
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.model.name),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.blue,
          indicatorWeight: 3,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          tabs: const [
            Tab(text: 'الشاشات'),
            Tab(text: 'Glass الحماية'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildList('screen'),
          _buildList('glass'),
        ],
      ),
    );
  }
}
