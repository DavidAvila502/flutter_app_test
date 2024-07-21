import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/models/pokemon/pokemon.dart';
import 'package:flutter_application_1/config/providers/auth_provider.dart';
import 'package:flutter_application_1/domain/use_cases/pokemon/pokemon_use_case.dart';
import 'package:flutter_application_1/infraestructure/driven_adapter/api/pokemon_api/pokemon_data_api.dart';
import 'package:flutter_application_1/presentation/widgets/pokemon_list.dart';
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
          children: [PokemonList(pokemons: pokemons)],
        ),
      );
    });
  }
}
