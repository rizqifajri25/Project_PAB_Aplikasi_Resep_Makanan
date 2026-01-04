import 'package:flutter/material.dart';
import '../data/menu_data.dart';
import 'detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,

      body: SafeArea(
        child: Column(
          children: [
            // =======================
            // CAROUSEL IMAGE
            // =======================
            SizedBox(
              height: 240,
              width: double.infinity,
              child: CarouselView(
                itemExtent: MediaQuery.of(context).size.width,
                children: menuList.map((menu) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailScreen(menu: menu),
                        ),
                      );
                    },
                    child: Image.asset(
                      menu.imageAsset,
                      fit: BoxFit.cover,
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 12),

            // =======================
            // LIST MENU
            // =======================
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: menuList.length,
                itemBuilder: (context, index) {
                  final menu = menuList[index];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(18),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailScreen(menu: menu),
                          ),
                        );
                      },
                      child: Container(
                        height: 90,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: colorScheme.surface,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                menu.imageAsset,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                menu.nama,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: colorScheme.onSurface,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
