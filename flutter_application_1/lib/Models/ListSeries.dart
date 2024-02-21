class ListSeries{
  String name ;
  String backdrop_path;
  String original_name;
  String overview;
  String poster_path;
  double popularity;
  String first_air_date;
  double vote_average;
  List<String> origin_country;
  //double genre_ids;

  ListSeries({
    required this.name,
    required this.backdrop_path,
    required this.original_name,
    required this.overview,
    required this.poster_path,
    required this.popularity,
    required this.first_air_date,
    required this.vote_average,
    required this.origin_country,
    //required this.genre_ids,

  });

  factory ListSeries.fromJson(Map<String,dynamic> json){
    return ListSeries(
      name: json["name"] ,
      backdrop_path: json["backdrop_path"],
      original_name: json["original_name"], 
      overview: json["overview"], 
      poster_path: json["poster_path"], 
      popularity: json["popularity"].toDouble(), 
      first_air_date: json["first_air_date"], 
      vote_average: json["vote_average"].toDouble(),
      origin_country:List<String>.from(json["origin_country"]),
      //genre_ids:json["genre_ids"].toDouble(),
    );
  }
}