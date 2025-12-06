// تعريف فئة الأقسام (الشاشات / Glass)
class Category {
  final String id;            // '1' للشاشات، '2' للـ Glass
  final String nameAr;
  final String description;
  final String imageAsset;
  final int primaryColor;
  final int secondaryColor;

  Category({
    required this.id,
    required this.nameAr,
    required this.description,
    required this.imageAsset,
    required this.primaryColor,
    required this.secondaryColor,
  });
}

// قسمان فقط: الشاشات المتوافقة و Glass الحماية
List<Category> appCategories = [
  Category(
    id: '1',
    nameAr: 'الشاشات المتوافقة',
    description: 'ابحث عن شاشات متوافقة لهاتفك',
    imageAsset: '📱',
    primaryColor: 0xFF1E88E5,
    secondaryColor: 0xFF42A5F5,
  ),
  Category(
    id: '2',
    nameAr: 'Glass الحماية',
    description: 'ابحث عن glass حماية متوافق',
    imageAsset: '🛡️',
    primaryColor: 0xFF43A047,
    secondaryColor: 0xFF66BB6A,
  ),
];

// تعريف الماركات
class Brand {
  final String id;     // '1'، '2' ...
  final String name;
  final String logoIcon;

  Brand({
    required this.id,
    required this.name,
    required this.logoIcon,
  });
}

List<Brand> phoneBrands = [
  Brand(id: '1', name: 'Samsung', logoIcon: 'S'),
  Brand(id: '2', name: 'Apple', logoIcon: 'A'),
  Brand(id: '3', name: 'Xiaomi', logoIcon: 'X'),
  Brand(id: '4', name: 'Oppo', logoIcon: 'O'),
  Brand(id: '5', name: 'Huawei', logoIcon: 'H'),
  Brand(id: '6', name: 'Realme', logoIcon: 'R'),
  Brand(id: '7', name: 'Vivo', logoIcon: 'V'),
  Brand(id: '8', name: 'Infinix', logoIcon: 'I'),
];

// تعريف موديلات الهواتف
class PhoneModel {
  final String id;        // '1'، '2' ...
  final String brandId;   // ترتبط بـ Brand.id
  final String name;

  PhoneModel({
    required this.id,
    required this.brandId,
    required this.name,
  });
}

// موديلات تجريبية
List<PhoneModel> phoneModels = [
  // Samsung (brandId = '1')
  PhoneModel(id: '1', brandId: '1', name: 'Galaxy A15'),
  PhoneModel(id: '2', brandId: '1', name: 'Galaxy A25'),
  PhoneModel(id: '3', brandId: '1', name: 'Galaxy A54'),
  PhoneModel(id: '4', brandId: '1', name: 'Galaxy S23'),
  PhoneModel(id: '5', brandId: '1', name: 'Galaxy S24'),
  PhoneModel(id: '6', brandId: '1', name: 'Galaxy M14'),

  // Apple (brandId = '2')
  PhoneModel(id: '7', brandId: '2', name: 'iPhone 11'),
  PhoneModel(id: '8', brandId: '2', name: 'iPhone 12'),
  PhoneModel(id: '9', brandId: '2', name: 'iPhone 13'),
  PhoneModel(id: '10', brandId: '2', name: 'iPhone 14'),
  PhoneModel(id: '11', brandId: '2', name: 'iPhone 15'),

  // Xiaomi (brandId = '3')
  PhoneModel(id: '12', brandId: '3', name: 'Redmi Note 11'),
  PhoneModel(id: '13', brandId: '3', name: 'Redmi Note 12'),
  PhoneModel(id: '14', brandId: '3', name: 'Redmi Note 13'),

  // Oppo (brandId = '4')
  PhoneModel(id: '15', brandId: '4', name: 'Oppo A57'),
  PhoneModel(id: '16', brandId: '4', name: 'Oppo A78'),

  // Huawei (brandId = '5')
  PhoneModel(id: '17', brandId: '5', name: 'Huawei Nova 9'),
  PhoneModel(id: '18', brandId: '5', name: 'Huawei Y9a'),
];

// تعريف التوافقات
class Compatibility {
  final String id;
  final String phoneModelId;   // يرتبط بـ PhoneModel.id
  final String type;           // 'screen' أو 'glass'
  final String compatibleWith; // اسم أو موديلات متوافقة
  final String notes;          // ملاحظات

  Compatibility({
    required this.id,
    required this.phoneModelId,
    required this.type,
    required this.compatibleWith,
    required this.notes,
  });
}

// قائمة التوافقات (شاشات + Glass) - تجريبية
List<Compatibility> compatibilities = [
  // شاشات Galaxy A15 (id = 1)
  Compatibility(
    id: '1',
    phoneModelId: '1',
    type: 'screen',
    compatibleWith: 'Galaxy A14',
    notes: 'نفس مقاس الشاشة، تأكد من رقم الفليكس.',
  ),
  Compatibility(
    id: '2',
    phoneModelId: '1',
    type: 'screen',
    compatibleWith: 'Galaxy A13',
    notes: 'تعمل لكن درجة السطوع أقل قليلاً.',
  ),

  // Glass حماية لـ Galaxy A15
  Compatibility(
    id: '3',
    phoneModelId: '1',
    type: 'glass',
    compatibleWith: 'Galaxy A25 / A24',
    notes: 'نفس واجهة الشاشة، مناسب تماماً.',
  ),

  // شاشات Galaxy A25 (id = 2)
  Compatibility(
    id: '4',
    phoneModelId: '2',
    type: 'screen',
    compatibleWith: 'Galaxy A24',
    notes: 'متوافق 100%.',
  ),
  Compatibility(
    id: '5',
    phoneModelId: '2',
    type: 'screen',
    compatibleWith: 'Galaxy A23',
    notes: 'مع تعديل خفيف في الهاؤوسينغ.',
  ),

  // Glass لـ Galaxy A25
  Compatibility(
    id: '6',
    phoneModelId: '2',
    type: 'glass',
    compatibleWith: 'Galaxy A15 / A14',
    notes: 'نفس أبعاد الواجهة الأمامية.',
  ),

  // شاشات Galaxy S23 (id = 4)
  Compatibility(
    id: '7',
    phoneModelId: '4',
    type: 'screen',
    compatibleWith: 'Galaxy S22',
    notes: 'نفس الشاشة تقريباً، اختلاف بسيط في الألوان.',
  ),

  // Glass لـ Galaxy S23
  Compatibility(
    id: '8',
    phoneModelId: '4',
    type: 'glass',
    compatibleWith: 'Galaxy S23 / S23+',
    notes: 'يجب التأكد من مقاس النسخة.',
  ),

  // شاشات iPhone 13 (id = 9)
  Compatibility(
    id: '9',
    phoneModelId: '9',
    type: 'screen',
    compatibleWith: 'iPhone 14',
    notes: 'تعمل مع اختلاف بسيط في السطوع.',
  ),
  Compatibility(
    id: '10',
    phoneModelId: '9',
    type: 'screen',
    compatibleWith: 'iPhone 13 Pro',
    notes: 'تحتاج نقل الفلاتات الأصلية.',
  ),

  // Glass لـ iPhone 13
  Compatibility(
    id: '11',
    phoneModelId: '9',
    type: 'glass',
    compatibleWith: 'iPhone 12 / 13 / 14',
    notes: 'جميعها نفس واجهة الشاشة.',
  ),

  // شاشات Redmi Note 12 (id = 13)
  Compatibility(
    id: '12',
    phoneModelId: '13',
    type: 'screen',
    compatibleWith: 'Redmi Note 11',
    notes: 'تعمل لكن الحواف تختلف قليلاً.',
  ),

  // Glass لـ Redmi Note 12
  Compatibility(
    id: '13',
    phoneModelId: '13',
    type: 'glass',
    compatibleWith: 'Redmi Note 12 / Note 12 Pro',
    notes: 'متطابقة تماماً في المقاس.',
  ),

  // مثال لموديل بدون توافقات كثيرة (لتجريب حالة "لا توجد بيانات")
  // iPhone 15 (id = 11) - لا نضيف له شيء الآن.
];

