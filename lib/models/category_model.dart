class CategoryModel {
  int? id;
  String? name;

  CategoryModel({
    required this.id,
    required this.name,
  });

  CategoryModel.fromJson(Map<String, dynamic> element) {
    id = element["id"];
    name = element["name"];
  }
}
