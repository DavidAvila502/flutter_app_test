import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  final void Function(String) setSearchParam;

  const Search({super.key, required this.setSearchParam});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          child: Row(
            children: [
              const Icon(
                Icons.search,
                color: Colors.grey,
              ),
              Expanded(
                child: TextField(
                    onChanged: (value) => widget.setSearchParam(value),
                    controller: _searchController,
                    decoration: const InputDecoration(
                        hintText: 'Enter a pokemon name...',
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
