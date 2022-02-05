class Sector {
  String name;
  List<String> category;
  String id;

  Sector({required this.name, required this.category, required this.id});
  factory Sector.fromJson(Map<String, dynamic> json) {
    return Sector(
      name: json['name'],
      category: json['category'],
      id: json['id']
    );
  }
}
