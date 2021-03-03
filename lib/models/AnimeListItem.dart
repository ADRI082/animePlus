import 'dart:convert';
import 'package:http/http.dart' as http;

class AnimeListItem {
  static const URL = "https://animeflv-webscrapper.herokuapp.com/animes/";

  String id;
  String imagen;
  String titulo;
  String ultimoEpisodio;
  int reviews;
  double rating;

  AnimeListItem({
    this.imagen = '',
    this.titulo = '',
    this.id = '',
    this.rating = 0,
    this.ultimoEpisodio = '',
    this.reviews = 0,
  });

  static Future<List<AnimeListItem>> getLista(String endPoint) async {
    List<AnimeListItem> lista;
    print(URL + endPoint);
    var response = await http.get(URL + endPoint);
    lista = (jsonDecode(response.body) as List).map((i) => AnimeListItem.fromJson(i)).toList();
    return lista;
  }

  factory AnimeListItem.fromJson(Map<String, dynamic> json) {
    return AnimeListItem(
      id : json['title'],
      imagen: json['image'],
      titulo: json['label'],
      ultimoEpisodio: json['episode'],
      rating: double.parse(json['rate']),
      reviews: int.parse(json['votes'])
    );
  }
}
