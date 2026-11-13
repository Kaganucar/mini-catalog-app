import 'package:flutter/material.dart';
import '../widgets/product_image.dart';
import '../models/product_model.dart';

class CartScreen extends StatefulWidget {
  final List<Product> cartItems;
  final ValueChanged<Product> onRemove;
  final VoidCallback onCheckout;

  const CartScreen({super.key, required this.cartItems, required this.onRemove, required this.onCheckout});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Product> get cartItems => widget.cartItems;

  Future<void> _checkout() async {
    final total = cartItems.fold<double>(0, (sum, item) {
      final amount = item.price.replaceAll(RegExp(r'[^0-9.]'), '');
      return sum + (double.tryParse(amount) ?? 0);
    });
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Order summary'),
        content: Text(
          '${cartItems.length} item(s) · Total: \$${total.toStringAsFixed(2)}\n'
          'Demo order. No payment will be taken.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Place demo order'),
          ),
        ],
      ),
    );
    if (!mounted || confirmed != true) return;

    setState(widget.onCheckout);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Demo order placed.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isEmpty = cartItems.isEmpty;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text('Cart', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          Expanded(
            child: isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey.shade300),
                  const SizedBox(height: 16),
                  const Text(
                    'Your cart is empty',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Add items to start shopping',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Row(
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F5F7),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: ProductImage(item.imageUrl),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            Text(item.tagline, style: const TextStyle(color: Colors.grey, fontSize: 12), maxLines: 1),
                            const SizedBox(height: 4),
                            Text(item.price, style: const TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline, color: Colors.grey),
                        tooltip: 'Remove item',
                        onPressed: () => setState(() => widget.onRemove(item)),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          Container(
            padding: const EdgeInsets.all(24),
            child: ElevatedButton(
              onPressed: isEmpty ? null : _checkout,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                disabledBackgroundColor: Colors.grey.shade300,
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Checkout', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}
