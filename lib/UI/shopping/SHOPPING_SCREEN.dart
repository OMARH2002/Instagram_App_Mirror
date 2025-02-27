import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_duplicate_app/LOGIC/SHOPPING/cubit.dart';
import 'package:instagram_duplicate_app/LOGIC/SHOPPING/state.dart';
import 'package:instagram_duplicate_app/UI/shopping/ITEM_CARD_SCREEN.dart';
import 'package:instagram_duplicate_app/UI/shopping/uplaod%20screen.dart';


class ShoppingScreen extends StatelessWidget {
  const ShoppingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Marketplace'),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const UploadScreen()),
        ),
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<ShoppingCubit, ShoppingState>(
        builder: (context, state) {
          if (state is ShoppingLoading) return const Center(child: CircularProgressIndicator());
          if (state is ShoppingError) return Center(child: Text(state.message));
          if (state is ShoppingLoaded) {
            return GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 0.8,
              ),
              itemCount: state.items.length,
              itemBuilder: (context, index) => ItemCard(item: state.items[index]),
            );
          }
          return const Center(child: Text('No items found'));
        },
      ),
    );
  }
}