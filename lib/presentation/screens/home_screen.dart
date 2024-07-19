import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/models/pokemon/pokemon.dart';
import 'package:flutter_application_1/config/providers/auth_provider.dart';
import 'package:flutter_application_1/domain/use_cases/pokemon/pokemon_use_case.dart';
import 'package:flutter_application_1/infraestructure/driven_adapter/api/pokemon_api/pokemon_data_api.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Pokemon>> pokemons;

  @override
  void initState() {
    super.initState();
    pokemons = PokemonUseCase(PokemonDataApi()).getPokemonList();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, value, child) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Home Screen'),
            ElevatedButton(
              onPressed: () {
                value.logout();
              },
              child: const Text('Logout'),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 400,
              width: 300,
              child: FutureBuilder<List<Pokemon>>(
                  future: pokemons,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.separated(
                        itemCount: snapshot.data!.length,
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(
                          height: 10,
                        ),
                        itemBuilder: (context, index) {
                          return Container(
                              decoration: const BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Text(snapshot.data![index].name),
                              ));
                        },
                      );
                    }

                    return const CircularProgressIndicator();
                  }),
            ),
          ],
        ),
      );
    });
  }
}
