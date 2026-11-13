import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  const ProductImage(this.source, {super.key, this.fit = BoxFit.contain});

  final String source;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    const placeholder = Icon(Icons.devices, color: Colors.grey);

    if (source.startsWith('assets/')) {
      return Image.asset(
        source,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          debugPrint('Product asset failed to load: $source ($error)');
          return placeholder;
        },
      );
    }

    return Image.network(
      source,
      fit: fit,
      errorBuilder: (context, error, stackTrace) => placeholder,
    );
  }
}
