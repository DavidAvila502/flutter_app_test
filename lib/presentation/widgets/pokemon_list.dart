import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/models/pokemon/pokemon.dart';
import 'package:flutter_application_1/presentation/widgets/pokemon_modal_content.dart';
import 'package:flutter_application_1/utils/get_emoji_of_pokemon_type.dart';

class PokemonList extends StatefulWidget {
  const PokemonList(
      {super.key,
      required this.pokemons,
      required this.isPokemonLoading,
      required this.scrollController});

  final List<Pokemon> pokemons;
  final bool isPokemonLoading;
  final ScrollController scrollController;

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
                color: Theme.of(context).primaryColor,
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
          child: GridView.builder(
              controller: widget.scrollController,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _isGrid ? 2 : 1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: _isGrid ? 0.9 : 3),
              itemCount: widget.pokemons.length + 1,
              itemBuilder: (context, index) {
                if (index == widget.pokemons.length) {
                  return widget.isPokemonLoading
                      ? const Center(child: CircularProgressIndicator())
                      : const SizedBox.shrink();
                }

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

                      GestureDetector(
                        child: pokemons[index].sprite != null
                            ? CircleAvatar(
                                backgroundImage: pokemons[index].sprite != null
                                    ? NetworkImage(pokemons[index].sprite!)
                                    : null,
                                minRadius: 40,
                                maxRadius: 40,
                              )
                            : Container(
                                padding: const EdgeInsets.all(30),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer),
                                child: Icon(
                                  Icons.image_not_supported,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return PokemonModalContent(
                                    pokemons: pokemons, index: index);
                              });
                        },
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
                                Text(getEmojiofPokemonType(type) ?? '❔'))
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
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.only(
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
    // * Grid container ***

    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: <Widget>[
          // * Image Container ***

          Container(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),

            // * Pokemon image ***

            child: GestureDetector(
              // child: Image(
              //     image: pokemons[index].sprite != null
              //         ? NetworkImage(pokemons[index].sprite!)
              //         : const NetworkImage('')),
              child: pokemons[index].sprite != null
                  ? Image(image: NetworkImage(pokemons[index].sprite!))
                  : Center(
                      child: Icon(
                        Icons.image_not_supported,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),

              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return PokemonModalContent(
                          pokemons: pokemons, index: index);
                    });
              },
            ),
          ),

          // * Pokemon name ***

          Text(pokemons[index].name,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),

          // * Types ***

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...pokemons[index]
                  .types
                  .map((type) => Text(getEmojiofPokemonType(type) ?? '❔'))
            ],
          ),
          const Spacer(),

          // * Pokemon number ***
          Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: const BorderRadius.only(
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
