import 'package:flutter/material.dart';
import 'package:motivo/model/quotes.dart';
import 'package:motivo/theme/app_theme.dart';
import 'package:motivo/widget/my_app_bar.dart';
import 'package:share_plus/share_plus.dart';

class HomeScreen extends StatefulWidget {
  final List<Quote> quotes;
  final Set<int> favoriteIds;
  final int currentIndex;
  final Function(int) toggleFavorite;
  final VoidCallback onRefresh;

  const HomeScreen({
    super.key,
    required this.quotes,
    required this.favoriteIds,
    required this.currentIndex,
    required this.toggleFavorite,
    required this.onRefresh,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (widget.quotes.isEmpty) {
      return const Scaffold(
        body: Center(
          child: Text(
            "No quotes found for this category",
            style: TextStyle(fontSize: 18),
          ),
        ),
      );
    }

    final quote = widget.quotes[widget.currentIndex];

    return Container(
      decoration: BoxDecoration(
        gradient: isDark ? AppTheme.darkGradient : AppTheme.lightGradient,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const MyAppbar(title: "Today's Quote"),
                const SizedBox(height: 30),

                Expanded(
                  child: SingleChildScrollView(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      elevation: 6,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          gradient: isDark
                              ? AppTheme.darkCardGradient
                              : AppTheme.lightCardGradient,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(32, 40, 32, 30),
                          child: Column(
                            children: [
                              Text(
                                quote.text,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),

                              const SizedBox(height: 16),

                              Text(
                                quote.author,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),

                              const SizedBox(height: 24),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: const Color(0xffE38272),
                                    radius: 20,
                                    child: IconButton(
                                      onPressed: () =>
                                          widget.toggleFavorite(quote.id),
                                      icon: Icon(
                                        widget.favoriteIds.contains(quote.id)
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color:
                                            widget.favoriteIds.contains(
                                              quote.id,
                                            )
                                            ? Colors.red
                                            : Colors.white,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(width: 16),

                                  CircleAvatar(
                                    backgroundColor: const Color(0xff93DDC2),
                                    radius: 20,
                                    child: IconButton(
                                      icon: const Icon(Icons.share),
                                      onPressed: () async {
                                        await SharePlus.instance.share(
                                          ShareParams(
                                            text:
                                                '"${quote.text}"\n\n- ${quote.author}\n\nShared from Motivo App',
                                          ),
                                        );
                                      },
                                    ),
                                  ),

                                  const SizedBox(width: 16),

                                  CircleAvatar(
                                    backgroundColor: const Color(0xff95C8E8),
                                    radius: 20,
                                    child: IconButton(
                                      onPressed: widget.onRefresh,
                                      icon: const Icon(Icons.arrow_forward),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // Container(
                //   decoration: BoxDecoration(
                //     // color: const Color(0xffE48573),
                //     borderRadius: BorderRadius.circular(12),
                //   ),
                //   width: double.infinity,
                //   height: 51,
                //   child: const BannerAdWidget(),
                // ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
