import 'package:flutter_application_1/domain/models/pokemon/pokemon.dart';
import 'package:flutter_application_1/domain/models/pokemon/repository/pokemon_repository.dart';
import 'package:flutter_application_1/domain/models/pokemon_page/pokemon_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PokemonDataApi extends PokemonRepository {
  @override
  Future<List<Pokemon>> getPokemonList(PokemonPage pokemonPage) async {
    Iterable<Future<Map<String, dynamic>>> pokemonListWithCompleteInfo =
        pokemonPage.results.map((currentPokemon) async {
      var pokemonUrl = Uri.parse(currentPokemon['url']);
      var response = await http.get(pokemonUrl);
      var decodeResponse = jsonDecode(response.body);

      Map<String, dynamic> currentPokemonCompletedata = {
        "name": decodeResponse['name'],
        "types": decodeResponse["types"]
            .map((type) => type['type']['name'])
            .toList(),
        "sprite": decodeResponse["sprites"]["other"]['official-artwork']
            ['front_default'],
        "id": decodeResponse["id"]
      };

      return currentPokemonCompletedata;
    });

    Future<List<Map<String, dynamic>>> futurePokemonList =
        Future.wait(pokemonListWithCompleteInfo);

    List<Map<String, dynamic>> pokemonList = await futurePokemonList;

    Iterable<Pokemon> finalPokemonList =
        pokemonList.map((item) => Pokemon.fromJson(item));
    return finalPokemonList.toList();
  }
}
