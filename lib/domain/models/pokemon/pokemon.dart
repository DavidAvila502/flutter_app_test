import 'dart:convert';

Pokemon? pokemonFromJson(String json) => Pokemon.fromJson(jsonDecode(json));

String pokemonToJson(Pokemon pokemon) => jsonEncode(pokemon.toJson());

class Pokemon {
  final String name;
  final List<String> types;
  final String? sprite;
  final int id;

  Pokemon(
      {required this.name, required this.types, this.sprite, required this.id});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
        name: json['name'],
        types: List<String>.from(json['types']),
        sprite: json["sprite"],
        id: json["id"]);
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'types': types, 'sprite': sprite, 'id': id};
  }
}
