import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/models/pokemon/pokemon.dart';

class PokemonList extends StatefulWidget {
  const PokemonList({super.key, required this.pokemons});

  final Future<List<Pokemon>> pokemons;

  @override
  State<PokemonList> createState() => _PokemonList();
}

class _PokemonList extends State<PokemonList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: 350,
      child: FutureBuilder<List<Pokemon>>(
          future: widget.pokemons,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                itemCount: snapshot.data!.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(
                  height: 10,
                ),
                itemBuilder: (context, index) {
                  return _ListItem(
                    snapshot: snapshot,
                    index: index,
                  );
                },
              );
            }

            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}

class _ListItem extends StatelessWidget {
  const _ListItem({required this.snapshot, required this.index});

  final AsyncSnapshot<List<Pokemon>> snapshot;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: snapshot.data![index].sprite != null
                        ? NetworkImage(snapshot.data![index].sprite!)
                        : null,
                    minRadius: 40,
                    maxRadius: 40,
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  Text(
                    snapshot.data![index].name,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Container(
              height: 100,
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
                  '#${snapshot.data![index].id.toString()}',
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ));
  }
}
