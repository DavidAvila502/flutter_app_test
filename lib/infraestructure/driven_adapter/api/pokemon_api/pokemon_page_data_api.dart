import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/domain/models/pokemon_page/pokemon_page.dart';
import 'package:flutter_application_1/domain/models/pokemon_page/repository/pokemon_page_repository.dart';

class PokemonPageDataApi extends PokemonPageRepository {
  @override
  Future<PokemonPage> getPokemonPage(String pageUrl) async {
    var pokemonPageUrl = Uri.parse(pageUrl);

    var response = await http.get(pokemonPageUrl);

    Map<String, dynamic> decodeResponse = jsonDecode(response.body);

    PokemonPage pokemonPage = PokemonPage.fromJson(decodeResponse);

    return pokemonPage;
  }
}
