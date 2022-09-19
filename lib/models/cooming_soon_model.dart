class ComingSoonModel {
  String? id;
  String? title;
  String? fullTitle;
  String? year;
  String? image;
  String? releaseState;

  ComingSoonModel({
    required this.id,
    required this.title,
    required this.fullTitle,
    required this.year,
    required this.image,
    required this.releaseState,
  });

  ComingSoonModel.fromJson(Map<String, dynamic> element) {
    id = element["id"];
    title = element["title"];
    fullTitle = element["fullTitle"];
    year = element["year"];
    image = element["image"];
    releaseState = element["releaseState"];
  }
}
