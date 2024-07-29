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
  String? pokemonPageUrl = 'https://pokeapi.co/api/v2/pokemon';
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    searchParam = '';
    fetchData();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        fetchData();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void setSearchParam(String param) {
    setState(() {
      searchParam = param;
    });

    _filterPokemons();
  }

  Future<void> fetchData() async {
    if (isPokemonLoading || searchParam != '') {
      return;
    }

    setState(() {
      isPokemonLoading = true;
    });

    if (pokemonPageUrl != null) {
      try {
        PokemonPage pokemonPage = await PokemonPageUseCase(PokemonPageDataApi())
            .getPokemonPage(pokemonPageUrl!);

        List<Pokemon> pokemonList =
            await PokemonUseCase(PokemonDataApi()).getPokemonList(pokemonPage);

        setState(() {
          pokemons.addAll(pokemonList);
          pokemonsFiltered = pokemons;
          isPokemonLoading = false;
          pokemonPageUrl = pokemonPage.nextPage;
        });
      } catch (error) {}
    }
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
            const SizedBox(
              height: 10,
            ),
            Search(setSearchParam: setSearchParam),
            const SizedBox(
              height: 10,
            ),
            PokemonList(
              pokemons: pokemonsFiltered,
              isPokemonLoading: isPokemonLoading,
              scrollController: _scrollController,
            ),
          ],
        ),
      );
    });
  }
}
