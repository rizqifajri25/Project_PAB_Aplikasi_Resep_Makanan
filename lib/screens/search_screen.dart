import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,

      appBar: AppBar(
        backgroundColor: colorScheme.background,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Cook.In',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Column(
        children: [
          // HEADER
          Container(
            height: 55,
            width: double.infinity,
            decoration: BoxDecoration(
              color: colorScheme.primary,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: colorScheme.onPrimary),
                  onPressed: () => Navigator.pop(context),
                ),

                Expanded(
                  child: Center(
                    child: Text(
                      'SEARCH',
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 48),
              ],
            ),
          ),

          // SEARCH FIELD
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 45,
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextField(
                style: theme.textTheme.bodyMedium,
                decoration: InputDecoration(
                  hintText: 'Cari Resep',
                  hintStyle: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface.withOpacity(0.6),
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: colorScheme.onSurface.withOpacity(0.7),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),

          const Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}
