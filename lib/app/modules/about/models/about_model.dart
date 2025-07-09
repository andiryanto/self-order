class About {
  final int id;
  final String name;
  final String position;
  final String? photo;
  final String? instagram;

  About({
    required this.id,
    required this.name,
    required this.position,
    this.photo,
    this.instagram,
  });

  factory About.fromJson(Map<String, dynamic> json) {
    return About(
      id: json['id'],
      name: json['name'],
      position: json['position'],
      photo: json['photo'],
      instagram: json['instagram'],
    );
  }
}
