import 'package:flutter_application_1/domain/models/pokemon/pokemon.dart';
import 'package:flutter_application_1/domain/models/pokemon/repository/pokemon_repository.dart';
import 'package:flutter_application_1/domain/models/pokemon_page/pokemon_page.dart';

class PokemonUseCase {
  final PokemonRepository pokemonRepository;
  PokemonUseCase(this.pokemonRepository);

  Future<List<Pokemon>> getPokemonList(PokemonPage pokemonPage) =>
      pokemonRepository.getPokemonList(pokemonPage);
}
