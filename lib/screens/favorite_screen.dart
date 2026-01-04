import 'package:flutter/material.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
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
          style: theme.textTheme.titleLarge?.copyWith(
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
                  icon: Icon(
                    Icons.arrow_back,
                    color: colorScheme.onPrimary,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),

                Expanded(
                  child: Center(
                    child: Text(
                      'FAVORITES',
                      style: theme.textTheme.titleMedium?.copyWith(
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

          // CONTENT
          Expanded(
            child: Center(
              child: Text(
                'Belum Ada Makanan Favorit',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.hintColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
