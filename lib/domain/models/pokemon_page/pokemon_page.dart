import 'dart:convert';

String pokemonPageToJson(PokemonPage page) => jsonEncode(page.toJson());

PokemonPage pokemonPageFromJson(Map<String, dynamic> json) =>
    PokemonPage.fromJson(json);

class PokemonPage {
  const PokemonPage(
      {required this.nextPage,
      required this.previousPage,
      required this.results});

  final String? nextPage;
  final String? previousPage;
  final List<dynamic> results;

  factory PokemonPage.fromJson(Map<String, dynamic> json) {
    return PokemonPage(
        nextPage: json['next'],
        previousPage: json['previous'],
        results: List<dynamic>.from(json['results']));
  }

  Map<String, dynamic> toJson() {
    return {
      'nextPage': nextPage,
      'previousPage': previousPage,
      'results': results
    };
  }
}
