import 'dart:convert';
import 'package:flutter_application_1/models/pokemon_model.dart';
import 'package:http/http.dart' as http;

Future<List<PokemonModel>> getPokemonList() async {
  var url = Uri.https('pokeapi.co', '/api/v2/pokemon/');
  var response = await http.get(url);

  var decodeResponse = jsonDecode(response.body);

  List<dynamic> pokemonListResults = decodeResponse['results'];

  Iterable<PokemonModel> pokemonModelResults = pokemonListResults.map(
      (element) => PokemonModel(name: element['name'], url: element['url']));

  return pokemonModelResults.toList();
}
