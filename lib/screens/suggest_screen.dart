import 'package:flutter/material.dart';

class SuggestScreen extends StatefulWidget {
  const SuggestScreen({Key? key}) : super(key: key);

  @override
  State<SuggestScreen> createState() => _SuggestScreenState();
}

class _SuggestScreenState extends State<SuggestScreen> {
  final _formKey = GlobalKey<FormState>();
  
  String? _selectedType = 'screen';
  final _brandController = TextEditingController();
  final _modelController = TextEditingController();
  final _compatibleWithController = TextEditingController();
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _brandController.dispose();
    _modelController.dispose();
    _compatibleWithController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _submitSuggestion() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم إرسال اقتراحك للمراجعة. شكراً لمساهمتك!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إضافة توافق جديد'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'نوع القطعة:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('شاشة'),
                      value: 'screen',
                      groupValue: _selectedType,
                      onChanged: (val) => setState(() => _selectedType = val),
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Glass'),
                      value: 'glass',
                      groupValue: _selectedType,
                      onChanged: (val) => setState(() => _selectedType = val),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _brandController,
                      decoration: const InputDecoration(
                        labelText: 'الماركة (مثلاً Samsung)',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => value!.isEmpty ? 'مطلوب' : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _modelController,
                      decoration: const InputDecoration(
                        labelText: 'الموديل (مثلاً A15)',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => value!.isEmpty ? 'مطلوب' : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _compatibleWithController,
                decoration: const InputDecoration(
                  labelText: 'يتوافق مع (مثلاً A14, A13...)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.link),
                ),
                validator: (value) => value!.isEmpty ? 'هذا الحقل ضروري' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _notesController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'ملاحظات إضافية (اختياري)',
                  hintText: 'هل تحتاج تعديل؟ هل الإضاءة ضعيفة؟...',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _submitSuggestion,
                icon: const Icon(Icons.send),
                label: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    'إرسال للمراجعة',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[700],
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
