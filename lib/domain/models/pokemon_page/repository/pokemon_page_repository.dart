import 'package:flutter_application_1/domain/models/pokemon_page/pokemon_page.dart';

abstract class PokemonPageRepository {
  Future<PokemonPage> getPokemonPage(String pageUrl);
}
