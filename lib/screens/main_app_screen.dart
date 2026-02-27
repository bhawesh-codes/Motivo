import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:motivo/model/quotes.dart';
import 'package:motivo/screens/category_screen.dart';
import 'package:motivo/screens/home_screen.dart';
import 'package:motivo/screens/favorite_screen.dart';
import 'package:motivo/theme/app_theme.dart';

class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key});

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  List<Quote> _quotes = [];
  bool _isLoading = true;
  int _currentIndex = 0;
  Set<int> _favoriteIds = {};
  int _pageIndex = 0;
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await loadQuotes();
  }

  Future<void> loadQuotes() async {
    try {
      final String jsonString = await rootBundle.loadString(
        'lib/data/quotes.json',
      );

      final List<Quote> loadedQuotes = quoteFromJson(jsonString);

      final prefs = await SharedPreferences.getInstance();
      final int savedIndex = prefs.getInt('lastIndex') ?? 0;
      final List<String>? savedFavorites = prefs.getStringList('favorites');

      setState(() {
        _quotes = loadedQuotes;
        _currentIndex = savedIndex < loadedQuotes.length ? savedIndex : 0;
        _favoriteIds = savedFavorites != null
            ? savedFavorites.map((e) => int.parse(e)).toSet()
            : {};
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Error loading quotes: $e');
      setState(() => _isLoading = false);
    }
  }

  List<Quote> get filteredQuotes {
  if (_selectedCategory == null) return _quotes;

  return _quotes.where((q) =>
      q.category.trim().toLowerCase() ==
      _selectedCategory!.trim().toLowerCase()
  ).toList();
}



  Future<void> toggleFavorite(int quoteId) async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      if (_favoriteIds.contains(quoteId)) {
        _favoriteIds.remove(quoteId);
      } else {
        _favoriteIds.add(quoteId);
      }
    });

    await prefs.setStringList(
      'favorites',
      _favoriteIds.map((e) => e.toString()).toList(),
    );
  }
void selectCategory(String category) {
  setState(() {
    _selectedCategory = category;
    _currentIndex = 0;
    _pageIndex = 0; 
  });
}



  Future<void> refreshQuote() async {
  final currentList = filteredQuotes;

  if (currentList.isEmpty) return;

  setState(() {
    _currentIndex = (_currentIndex + 1) % currentList.length;
  });
}


  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final List<Widget> screens = [
      HomeScreen(
        quotes: filteredQuotes,
        favoriteIds: _favoriteIds,
        currentIndex: _currentIndex,
        toggleFavorite: toggleFavorite,
        onRefresh: refreshQuote,
      ),
      FavoriteScreen(
        quotes: _quotes,
        favoriteIds: _favoriteIds,
        toggleFavorite: toggleFavorite,
      ),
      CategoryScreen(onCategorySelected: selectCategory),
    ];

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(child: screens[_pageIndex]),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: isDark
              ? AppTheme.darkBNBGradient
              : AppTheme.lightBNBGradient,
        ),
        child: BottomNavigationBar(
          currentIndex: _pageIndex,
          onTap: (index) => setState(() => _pageIndex = index),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: const Color(0xffF64E2E),
          unselectedItemColor: const Color(0xff2F4A43),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorite',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: 'Category',
            ),
          ],
        ),
      ),
    );
  }
}
