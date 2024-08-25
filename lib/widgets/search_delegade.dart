import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Return the search results here
    return const Center(
      child: Text('Search results'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Return the search suggestions here
    return const Center(
      child: Text('Search suggestions'),
    );
  }
}
