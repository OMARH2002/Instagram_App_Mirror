import 'package:flutter/material.dart';
import 'package:instagram_duplicate_app/DATA/shopping_Model.dart';


class ItemCard extends StatelessWidget {
  final ShoppingItem item;

  const ItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Image.network(item.imageUrl, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.title, style: Theme.of(context).textTheme.titleMedium),
                Text('\$${item.price.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.bodyLarge),
                Text(item.location,
                    style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}