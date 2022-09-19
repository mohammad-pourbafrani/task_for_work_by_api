class DataUserModel {
  String? id;
  String? name;
  String? email;

  DataUserModel({
    required this.id,
    required this.name,
    required this.email,
  });

  DataUserModel.fromJson(Map<String, dynamic> element) {
    id = element["id"];
    name = element["name"];
    email = element["email"];
  }
}
