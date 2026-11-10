class SubcategoryModel {
  final int id;
  final String name;

  SubcategoryModel({
    required this.id,
    required this.name,
  });

  factory SubcategoryModel.fromJson(Map<String, dynamic> json) {
    return SubcategoryModel(
      id: json['id'] is num ? (json['id'] as num).toInt() : 0,
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class CategoryModel {
  final int id;
  final String name;
  final String type;
  final List<SubcategoryModel> subcategories;

  CategoryModel({
    required this.id,
    required this.name,
    required this.type,
    required this.subcategories,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    var subList = json['subcategories'] as List? ?? [];
    List<SubcategoryModel> parsedSubcategories =
        subList.map((item) => SubcategoryModel.fromJson(item)).toList();

    return CategoryModel(
      id: json['id'] is num ? (json['id'] as num).toInt() : 0,
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      subcategories: parsedSubcategories,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'subcategories': subcategories.map((e) => e.toJson()).toList(),
    };
  }
}
