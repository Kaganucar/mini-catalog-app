import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mini_katalog_uygulamasi/models/product_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('Bundled catalog can be read by the product model', () async {
    final source = await rootBundle.loadString('assets/wantapi.json');
    final catalog = jsonDecode(source) as Map<String, dynamic>;
    final entries = (catalog['data'] as List).cast<Map<String, dynamic>>();
    final products = entries.map(Product.fromJson).toList();

    expect(products, hasLength(20));
    expect(products.map((product) => product.id).toSet(), hasLength(20));
    final localProducts = products.where(
      (product) => product.imageUrl.startsWith('assets/products/'),
    );
    expect(localProducts, hasLength(20));
    for (final product in localProducts) {
      final bytes = await rootBundle.load(product.imageUrl);
      expect(bytes.lengthInBytes, greaterThan(0));
    }

    final legacyEntry = Map<String, dynamic>.from(
      entries.firstWhere((entry) => entry['id'] == 1),
    )..['image'] = 'https://wantapi.com/assets/images/iphone.png';
    expect(
      Product.fromJson(legacyEntry).imageUrl,
      'assets/products/iphone.png',
    );
  });
}
