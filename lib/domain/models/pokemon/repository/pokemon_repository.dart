import 'package:flutter_application_1/domain/models/pokemon/pokemon.dart';

abstract class PokemonRepository {
  Future<List<Pokemon>> getPokemonList();
}
