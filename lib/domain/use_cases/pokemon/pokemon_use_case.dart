import 'package:flutter_application_1/domain/models/pokemon/pokemon.dart';
import 'package:flutter_application_1/domain/models/pokemon/repository/pokemon_repository.dart';

class PokemonUseCase {
  final PokemonRepository pokemonRepository;
  PokemonUseCase(this.pokemonRepository);

  Future<List<Pokemon>> getPokemonList() => pokemonRepository.getPokemonList();
}
