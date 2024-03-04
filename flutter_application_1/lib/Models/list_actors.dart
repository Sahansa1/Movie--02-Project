class ListActors {
  int id;
  String name;
  String original_name;
 // String media_type;
  double popularity;
  int gender;
  String known_for_department;
  String profile_path;
  List<Map<String, dynamic>> known_for;

  ListActors({
    required this.id,
    required this.name,
    required this.original_name,
    //required this.media_type,
    required this.popularity,
    required this.gender,
    required this.known_for_department,
    required this.profile_path,
    required this.known_for,
  });

  factory ListActors.fromJson(Map<String, dynamic> json) {
    return ListActors(
      id: json["id"],
      name: json["name"],
      original_name: json["original_name"],
      //media_type: json["media_type"],
      popularity: json["popularity"].toDouble(),
      gender: json["gender"],
      known_for_department: json["known_for_department"],
      profile_path: json["profile_path"],
      known_for: List<Map<String, dynamic>>.from(json["known_for"]),
    );
  }
}