import 'package:flutter/material.dart';
import 'package:labdev/models/cart_manager.dart';
import 'package:labdev/screens/cart/components/cart_tile.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
      ),

      body: Consumer<CartManager>(
        builder: (context, cartManager, __) {
          return Column(
             children: cartManager.items.map((cartProduct) => CartTile(cartProduct)).toList(),
          );
        },
      ),
    );
  }
}
