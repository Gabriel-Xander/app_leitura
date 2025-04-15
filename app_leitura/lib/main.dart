import 'package:flutter/material.dart';
import 'core/theme.dart';
import 'pages/livros_page.dart';

void main() => runApp(const LivrosApp());

class LivrosApp extends StatelessWidget {
  const LivrosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Livros Lidos',
      theme: appTheme,
      home: const LivrosPage(),
    );
  }
}
