import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies/src/models/pelicula_model.dart';

class PeliculasProviders {
  String _apyKey = 'ee43515f5b5ad1ccc992d00ce042147f';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);
    final peliculas = new Peliculas.fromJsonList(decodeData['results']);

    return peliculas.items;
  }

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing',
        {'api_key': _apyKey, 'language': _language});

    return await _procesarRespuesta(url);
  }

  Future<List<Pelicula>> getPopulares() async {
    final url = Uri.https(
        _url, '3/movie/popular', {'api_key': _apyKey, 'language': _language});

    return await _procesarRespuesta(url);
  }
}
