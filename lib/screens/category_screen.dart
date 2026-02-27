import 'package:flutter/material.dart';
import 'package:motivo/theme/app_theme.dart';
import 'package:motivo/widget/my_app_bar.dart';

class CategoryScreen extends StatelessWidget {
  final Function(String) onCategorySelected;

  CategoryScreen({super.key, required this.onCategorySelected});

  final List<String> categogies = [
    'Success',
    'Discipline',
    'Study',
    'Fitness',
    'SelfLove',
    'Leadership',
  ];
  final List<String> icon = [
    'assets/images/success_icon.png',
    'assets/images/discipline.png',
    'assets/images/study.png',
    'assets/images/fitness.png',
    'assets/images/selflove.png',
    'assets/images/leadership.png',
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
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
                const MyAppbar(title: 'Categories'),
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
                  child: ListView.separated(
                    itemCount: categogies.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: isDark ? const Color(0xff000000) : const Color(0xffC2DEE7),
                        elevation: 6,
                        child: SizedBox(
                          height: 74,
                          child: ListTile(
                            leading: Image.asset(
                              icon[index],
                              width: 45,
                              height: 45,
                            ),
                            title: Text(
                              categogies[index],
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            onTap: () {
                              onCategorySelected(categogies[index]);
                            },
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (_, _) {
                      return const SizedBox(height: 16);
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
