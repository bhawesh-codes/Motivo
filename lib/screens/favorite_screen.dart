import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motivo/model/quotes.dart';
import 'package:motivo/theme/app_theme.dart';
import 'package:motivo/widget/my_app_bar.dart';

class FavoriteScreen extends StatelessWidget {
  final List<Quote> quotes;
  final Set<int> favoriteIds;
  final Function(int) toggleFavorite;
  const FavoriteScreen({
    super.key,
    required this.quotes,
    required this.favoriteIds,
    required this.toggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final favoriteQuotes = quotes
        .where((q) => favoriteIds.contains(q.id))
        .toList();
    return Container(
      decoration: BoxDecoration(
        gradient: isDark ? AppTheme.darkGradient : AppTheme.lightGradient,
      ),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const MyAppbar(title: 'Favorites'),
                const SizedBox(height: 20),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      hintStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                      prefixIcon: Icon(Icons.search),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                Expanded(
                  child: favoriteQuotes.isEmpty
                      ? Center(
                          child: Text(
                            "No favorites yet ❤️",
                            style: GoogleFonts.inriaSerif(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: favoriteQuotes.length,
                          itemBuilder: (context, index) {
                            final quote = favoriteQuotes[index];
                            return Card(
                              color: isDark ? const Color(0xff000000) : const Color(0xffC2DEE7),
                              elevation: 6,
                              child: ListTile(
                                title: Text(
                                  quote.text,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  textAlign: TextAlign.center,
                                ),
                                subtitle: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const SizedBox(width: 70),
                                    Text(
                                      quote.author,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodySmall,
                                      textAlign: TextAlign.center,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        toggleFavorite(quote.id);
                                      },
                                      icon: Icon(
                                        favoriteIds.contains(quote.id)
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: favoriteIds.contains(quote.id)
                                            ? const Color(0xffF64E2E)
                                            : Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
