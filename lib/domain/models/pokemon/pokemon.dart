import 'dart:convert';

Pokemon? pokemonFromJson(String json) => Pokemon.fromJson(jsonDecode(json));

String pokemonToJson(Pokemon pokemon) => jsonEncode(pokemon.toJson());

class Pokemon {
  final String name;
  final String url;

  Pokemon({required this.name, required this.url});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(name: json['name'], url: json['url']);
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'url': url};
  }
}
