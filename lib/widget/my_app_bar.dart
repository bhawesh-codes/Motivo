import 'package:flutter/material.dart';

class MyAppbar extends StatelessWidget {
  const MyAppbar({required this.title, super.key});
  final String title;
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/lotus_logo.png',
          color: isDark ? Colors.white : Colors.black54,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            const CircleAvatar(
              radius: 18,
              backgroundColor: Color(0xff6C6565),
              child: Icon(Icons.person, color: Colors.white),
            ),
          ],
        ),
      ],
    );
  }
}
