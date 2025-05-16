import 'package:flutter/material.dart';

import '../../../shared/components/custom_search_field.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
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
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: CustomSearchField(
              controller: _searchController,
              hintText: 'Search destinations...',
              onSubmitted: (value) {
                // Handle search submission
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 15,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.place),
                  title: Text('Destination ${index + 1}'),
                  subtitle: Text('Description for destination ${index + 1}'),
                  onTap: () {
                    // Handle destination selection
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
