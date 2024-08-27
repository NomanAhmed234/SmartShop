import 'package:sneaker_shoes_app/models/data_model.dart';

class CartItem {
  final DataModel product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}
