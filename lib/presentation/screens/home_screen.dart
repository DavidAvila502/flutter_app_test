import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/models/pokemon/pokemon.dart';
import 'package:flutter_application_1/config/providers/auth_provider.dart';
import 'package:flutter_application_1/domain/models/pokemon_page/pokemon_page.dart';
import 'package:flutter_application_1/domain/use_cases/pokemon/pokemon_use_case.dart';
import 'package:flutter_application_1/domain/use_cases/pokemon_page/pokemon_page_use_case.dart';
import 'package:flutter_application_1/infraestructure/driven_adapter/api/pokemon_api/pokemon_data_api.dart';
import 'package:flutter_application_1/infraestructure/driven_adapter/api/pokemon_api/pokemon_page_data_api.dart';
import 'package:flutter_application_1/presentation/widgets/pokemon_list.dart';
import 'package:flutter_application_1/presentation/widgets/search.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Pokemon> pokemonsFiltered = [];
  List<Pokemon> pokemons = [];
  String searchParam = '';
  bool isPokemonLoading = false;

  @override
  void initState() {
    super.initState();
    searchParam = '';
    fetchData();
  }

  void setSearchParam(String param) {
    setState(() {
      searchParam = param;
    });

    _filterPokemons();
  }

  Future<void> fetchData() async {
    setState(() {
      isPokemonLoading = true;
    });

    PokemonPage pokemonPage = await PokemonPageUseCase(PokemonPageDataApi())
        .getPokemonPage('https://pokeapi.co/api/v2/pokemon');

    List<Pokemon> data =
        await PokemonUseCase(PokemonDataApi()).getPokemonList(pokemonPage);

    setState(() {
      pokemons = data;
      pokemonsFiltered = data;
      isPokemonLoading = false;
    });
  }

  void _filterPokemons() {
    setState(() {
      pokemonsFiltered = pokemons.where((pokemon) {
        return pokemon.name.contains(searchParam.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, value, child) {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Search(setSearchParam: setSearchParam),
            const SizedBox(
              height: 30,
            ),
            PokemonList(
              pokemons: pokemonsFiltered,
              isPokemonLoading: isPokemonLoading,
            )
          ],
        ),
      );
    });
  }
}
