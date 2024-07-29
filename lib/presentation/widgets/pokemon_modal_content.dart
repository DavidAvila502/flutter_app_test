import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/models/pokemon/pokemon.dart';
import 'package:flutter_application_1/utils/get_emoji_of_pokemon_type.dart';

class PokemonModalContent extends StatelessWidget {
  final List<Pokemon> pokemons;
  final int index;

  const PokemonModalContent(
      {super.key, required this.pokemons, required this.index});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          pokemons[index].sprite != null
              ? CircleAvatar(
                  backgroundImage: pokemons[index].sprite != null
                      ? NetworkImage(pokemons[index].sprite!)
                      : null,
                  minRadius: 60,
                  maxRadius: 60,
                )
              : Container(
                  padding: const EdgeInsets.all(40),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).colorScheme.primaryContainer),
                  child: Icon(
                    Icons.image_not_supported,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
          const SizedBox(
            height: 20,
          ),
          Text(
            pokemons[index].name,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Types',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            ...pokemons[index].types.map((type) => Row(
                  children: [
                    Text(getEmojiofPokemonType(type) ?? '❔'),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      type,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 16),
                    )
                  ],
                ))
          ])
        ],
      ),
    );
  }
}
