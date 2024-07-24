import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/models/pokemon/pokemon.dart';

class PokemonList extends StatefulWidget {
  const PokemonList(
      {super.key, required this.pokemons, required this.isPokemonLoading});

  final List<Pokemon> pokemons;
  final bool isPokemonLoading;

  @override
  State<PokemonList> createState() => _PokemonList();
}

class _PokemonList extends State<PokemonList> {
  bool _isGrid = false;

  void setIsGrid() {
    setState(() {
      _isGrid = !_isGrid;
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Column(children: <Widget>[
      // * GRID - LIST BUTTON ***

      SizedBox(
        width: screenSize.width * 0.9,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: setIsGrid,
              child: Icon(
                _isGrid ? Icons.grid_3x3 : Icons.list,
                size: 30,
                color: Colors.blue,
              ),
            ),
            const SizedBox(
              width: 10,
            )
          ],
        ),
      ),

      const SizedBox(
        height: 10,
      ),

      // * POKEMON LIST ***

      SizedBox(
          height: screenSize.height * 0.7,
          width: screenSize.width * 0.9,
          child: widget.isPokemonLoading
              ? const Center(child: CircularProgressIndicator())
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: _isGrid ? 2 : 1,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: _isGrid ? 0.9 : 3),
                  itemCount: widget.pokemons.length,
                  itemBuilder: (context, index) {
                    return !_isGrid
                        ? _ListItem(pokemons: widget.pokemons, index: index)
                        : _GridItem(pokemons: widget.pokemons, index: index);
                  }))
    ]);
  }
}

class _ListItem extends StatelessWidget {
  const _ListItem({required this.pokemons, required this.index});

  final List<Pokemon> pokemons;
  final int index;

  @override
  Widget build(BuildContext context) {
    return
        // * CARD CONTAINER ***
        Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: const BorderRadius.all(Radius.circular(20))),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      // * POKEMON IMAGE

                      CircleAvatar(
                        backgroundImage: pokemons[index].sprite != null
                            ? NetworkImage(pokemons[index].sprite!)
                            : null,
                        minRadius: 40,
                        maxRadius: 40,
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // * POKEMON NAME

                          Text(
                            pokemons[index].name,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),

                          // * POKEMON TYPES
                          Row(children: [
                            ...pokemons[index].types.map((type) =>
                                Text(_getEmojiofPokemonType(type) ?? '❔'))
                          ])
                        ],
                      )
                    ],
                  ),
                ),
                const Spacer(),

                // * POKEMON NUMBER

                Container(
                  height: double.infinity,
                  width: 80,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '#${pokemons[index].id.toString()}',
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ));
  }
}

class _GridItem extends StatelessWidget {
  const _GridItem({required this.pokemons, required this.index});

  final List<Pokemon> pokemons;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Image(
                image: pokemons[index].sprite != null
                    ? NetworkImage(pokemons[index].sprite!)
                    : const NetworkImage('')),
          ),
          Text(pokemons[index].name,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...pokemons[index]
                  .types
                  .map((type) => Text(_getEmojiofPokemonType(type) ?? '❔'))
            ],
          ),
          const Spacer(),
          Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: Text('#${pokemons[index].id.toString()}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    )),
              ))
        ],
      ),
    );
  }
}

String? _getEmojiofPokemonType(String type) {
  const Map<String, String> emojiType = {
    'normal': '♟️',
    'fighting': '👊🏼',
    'flying': '🪽',
    'poison': '🟣',
    'ground': '⛱️',
    'rock': '🪨',
    'bug': '🐞',
    'ghost': '👻',
    'steel': '🩶',
    'fire': '🔥',
    'water': '🐟',
    'grass': '🌿',
    'electrict': '⚡',
    'psychic': '🪬',
    'ice': '🧊',
    'dragon': '🐉',
    'dark': '🎩',
    'fairy': '✨',
    'stellar': '⭐',
    'unknown': '❔'
  };

  return emojiType[type];
}
