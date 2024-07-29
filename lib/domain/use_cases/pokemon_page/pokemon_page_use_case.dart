import 'package:flutter_application_1/domain/models/pokemon_page/pokemon_page.dart';
import 'package:flutter_application_1/domain/models/pokemon_page/repository/pokemon_page_repository.dart';

class PokemonPageUseCase {
  final PokemonPageRepository pokemonPageRepository;

  PokemonPageUseCase(this.pokemonPageRepository);

  Future<PokemonPage> getPokemonPage(String pageUrl) =>
      pokemonPageRepository.getPokemonPage(pageUrl);
}
