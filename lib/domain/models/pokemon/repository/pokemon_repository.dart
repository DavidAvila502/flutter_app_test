import 'package:flutter_application_1/domain/models/pokemon/pokemon.dart';
import 'package:flutter_application_1/domain/models/pokemon_page/pokemon_page.dart';

abstract class PokemonRepository {
  Future<List<Pokemon>> getPokemonList(PokemonPage pokemonPage);
}
