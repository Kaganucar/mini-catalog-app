import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mini_katalog_uygulamasi/models/product_model.dart';
import 'package:mini_katalog_uygulamasi/screens/cart_screen.dart';

void main() {
  testWidgets('Removing and checking out refreshes the open cart', (tester) async {
    final product = Product(
      id: 20,
      name: 'HomePod Mini',
      tagline: 'Color-pop.',
      description: '',
      price: r'$99',
      imageUrl: 'assets/products/homepod_mini.png',
      specs: {},
    );
    final cart = [product, product];

    await tester.pumpWidget(MaterialApp(
      home: CartScreen(
        cartItems: cart,
        onRemove: (item) => cart.remove(item),
        onCheckout: cart.clear,
      ),
    ));

    await tester.tap(find.byTooltip('Remove item').first);
    await tester.pumpAndSettle();
    expect(find.text(product.name), findsOneWidget);

    await tester.tap(find.text('Checkout'));
    await tester.pumpAndSettle();
    expect(find.textContaining(r'$99.00'), findsOneWidget);
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(cart, hasLength(1));

    await tester.tap(find.text('Checkout'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Place demo order'));
    await tester.pumpAndSettle();
    expect(cart, isEmpty);
    expect(find.text('Your cart is empty'), findsOneWidget);
    expect(find.text('Demo order placed.'), findsOneWidget);
  });
}
