import 'package:flutter_application_1/domain/models/pokemon/pokemon.dart';
import 'package:flutter_application_1/domain/models/pokemon/repository/pokemon_repository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PokemonDataApi extends PokemonRepository {
  @override
  Future<List<Pokemon>> getPokemonList() async {
    var url = Uri.https('pokeapi.co', '/api/v2/pokemon/');
    var response = await http.get(url);

    var decodeResponse = jsonDecode(response.body);

    List<dynamic> results = decodeResponse['results'];

    Iterable<Pokemon> pokemonList =
        results.map((item) => Pokemon(name: item['name'], url: item['url']));

    return pokemonList.toList();
  }
}
