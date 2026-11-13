import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/discover_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final source = await rootBundle.loadString('assets/wantapi.json');
  final catalog = jsonDecode(source) as Map<String, dynamic>;
  final products = (catalog['data'] as List).cast<Map<String, dynamic>>();
  runApp(MiniCatalogApp(products: products));
}

class MiniCatalogApp extends StatelessWidget {
  const MiniCatalogApp({super.key, required this.products});

  final List<Map<String, dynamic>> products;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gift Store',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      home: DiscoverScreen(rawData: products),
    );
  }
}
