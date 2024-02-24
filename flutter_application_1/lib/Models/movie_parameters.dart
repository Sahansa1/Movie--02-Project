class Cast {
  int id;
  String name;
  String character;

  Cast({
    required this.id, 
    required this.name, 
    required this.character
  });

  factory Cast.fromJson(Map<String, dynamic> json) {
    return Cast(
      id: json['id'],
      name: json['name'],
      character: json['character'],
    );
  }
}

