class ListMovies{
  String title ;
  String backdrop_path;
  String original_title;
  String overview;
  String poster_path;
  double popularity;
  String release_date;
  double vote_average;

  ListMovies({
    required this.title,
    required this.backdrop_path,
    required this.original_title,
    required this.overview,
    required this.poster_path,
    required this.popularity,
    required this.release_date,
    required this.vote_average,

  });

  factory ListMovies.fromJson(Map<String,dynamic> json){
    return ListMovies(
      title: json["title"] ,
      backdrop_path: json["backdrop_path"],
      original_title: json["original_title"], 
      overview: json["overview"], 
      poster_path: json["poster_path"], 
      popularity: json["popularity"], 
      release_date: json["release_date"], 
      vote_average: json["vote_average"],
    );
  }

// Map<String, dynamic> toJson() => {
//    "title": title,
//  "backdrop_path"  
// }
}
