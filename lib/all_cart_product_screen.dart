import 'package:flutter/material.dart';
import 'package:sneaker_shoes_app/models/cart_item_model.dart';

class AllProductCartScreen extends StatelessWidget {
  final List<CartItem> cartItems;

  const AllProductCartScreen({Key? key, required this.cartItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final cartItem = cartItems[index];
          return ListTile(
            leading: Image.network(cartItem.product.images![0]),
            title: Text(cartItem.product.title!),
            subtitle: Text("Quantity: ${cartItem.quantity}"),
            trailing: Text("\$${cartItem.product.price! * cartItem.quantity}"),
          );
        },
      ),
    );
  }
}
