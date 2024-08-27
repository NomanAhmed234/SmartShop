import 'dart:math';
import 'package:sneaker_shoes_app/models/data_model.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:sneaker_shoes_app/all_cart_product_screen.dart';
import 'package:sneaker_shoes_app/colors.dart';
import 'package:sneaker_shoes_app/models/cart_item_model.dart';

import 'package:sneaker_shoes_app/models/data_model.dart';

class ProductDetailsScreen extends StatefulWidget {
  final DataModel item;

  const ProductDetailsScreen({Key? key, required this.item}) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  List<CartItem> cartItems = [];
  double getRandomRating(double min, double max) {
    final random = Random();
    return double.parse(
        (min + (random.nextDouble() * (max - min))).toStringAsFixed(1));
  }

  void addToCart() {
    setState(() {
      CartItem? existingItem = cartItems.firstWhere(
        (cartItem) => cartItem.product.id == widget.item.id,
        orElse: () => CartItem(product: widget.item),
      );

      if (existingItem.product.id == widget.item.id) {
        existingItem.quantity++;
      } else {
        cartItems.add(CartItem(product: widget.item));
      }

      // Debugging output
      print("Cart Items: ${cartItems.length}");
      cartItems.forEach((item) {
        print("Product ID: ${item.product.id}, Quantity: ${item.quantity}");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double rating = getRandomRating(4.1, 4.9);
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        foregroundColor: CustomColors.lightGreen,
        centerTitle: true,
        title: Text(widget.item.category!.name!),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: EdgeInsets.zero,
              elevation: 0,
              backgroundColor: CustomColors.lightGreen.withOpacity(0.1),
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: CustomColors.lightGreen,
              size: 20,
            ),
          ),
        ),
        actions: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 20),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: CustomColors.lightGreen.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Text(
                      rating
                          .toString(), // This is hardcoded, consider using real rating data
                      style: TextStyle(
                        fontSize: 14,
                        color: CustomColors.lightGreen,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(Icons.star)
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: ListView(
        children: [
          ProductImages(item: widget.item),
          TopRoundedContainer(
            color: CustomColors.lightGreen.withOpacity(0.1),
            child: Column(
              children: [
                ProductDescription(
                  item: widget.item,
                  pressOnSeeMore: () {},
                ),
                TopRoundedContainer(
                  color: CustomColors.lightGreen.withOpacity(0.1),
                  child: Column(
                    children: [
                      ColorDots(item: widget.item),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: TopRoundedContainer(
        color: Colors.white,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: CustomColors.purple,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 48),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
              ),
              onPressed: () {
                addToCart();

                // Navigate to AllCartProductScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AllProductCartScreen(cartItems: cartItems),
                  ),
                );
              },
              child: const Text("Add To Cart"),
            ),
          ),
        ),
      ),
    );
  }
}

void itemAdd() {}

class TopRoundedContainer extends StatefulWidget {
  const TopRoundedContainer({
    Key? key,
    required this.color,
    required this.child,
  }) : super(key: key);

  final Color color;
  final Widget child;

  @override
  State<TopRoundedContainer> createState() => _TopRoundedContainerState();
}

class _TopRoundedContainerState extends State<TopRoundedContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.only(top: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: widget.child,
    );
  }
}

class ProductImages extends StatefulWidget {
  const ProductImages({
    Key? key,
    required this.item,
  }) : super(key: key);

  final DataModel item;

  @override
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  int selectedImage = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 238,
          child: ClipRRect(
            borderRadius:
                BorderRadius.circular(16.0), // Ensure the radius matches
            child: Hero(
              tag: 'hero-image',
              child: Image.network(
                widget.item.images![selectedImage],
                fit: BoxFit.cover,
              ),
            ),
          ),
          // AspectRatio(
          //   aspectRatio: 1,
          //   child: Image.network(widget.item.images![selectedImage]),
          // ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(
                widget.item.images!.length,
                (index) => SmallProductImage(
                  isSelected: index == selectedImage,
                  press: () {
                    setState(() {
                      selectedImage = index;
                    });
                  },
                  image: widget.item.images![index],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class SmallProductImage extends StatefulWidget {
  const SmallProductImage({
    super.key,
    required this.isSelected,
    required this.press,
    required this.image,
  });

  final bool isSelected;
  final VoidCallback press;
  final String image;

  @override
  State<SmallProductImage> createState() => _SmallProductImageState();
}

class _SmallProductImageState extends State<SmallProductImage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.press,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.all(8),
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: CustomColors.lightGreen
                  .withOpacity(widget.isSelected ? 1 : 0)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Hero(
            tag: 'hero-image',
            child: Image.network(
              widget.image,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

class ProductDescription extends StatefulWidget {
  const ProductDescription({
    Key? key,
    required this.item,
    this.pressOnSeeMore,
  }) : super(key: key);

  final DataModel item;
  final GestureTapCallback? pressOnSeeMore;

  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  bool isFavorite = false;
  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
      // if (isFavorite) {
      //   favoriteProducts.add(widget.item); // Add to favorites
      // } else {
      //   favoriteProducts.remove(widget.item); // Remove from favorites
      // }
    });
  }

  bool isExpanded = false;

  void toggleDescription() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            widget.item.title!.toString(),
            style: TextStyle(
                color: CustomColors.purple,
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            padding: const EdgeInsets.all(16),
            width: 48,
            decoration: BoxDecoration(
              color: CustomColors.lightGreen.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: GestureDetector(
              onTap: toggleFavorite,
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite
                    ? CustomColors.lightGreen
                    : CustomColors.lightGreen,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 64),
          child: Text(
            widget.item.description!,
            style: TextStyle(color: CustomColors.purple),
            maxLines: isExpanded ? null : 3, // Expand the description if true
            overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: GestureDetector(
            onTap: toggleDescription,
            child: Row(
              children: [
                Text(
                  isExpanded ? "See Less" : "See More Detail",
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: CustomColors.lightGreen),
                ),
                const SizedBox(width: 5),
                Icon(
                    isExpanded ? Icons.arrow_back_ios : Icons.arrow_forward_ios,
                    size: 12,
                    color: CustomColors.lightGreen),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ColorDots extends StatefulWidget {
  const ColorDots({
    Key? key,
    required this.item,
  }) : super(key: key);

  final DataModel item;

  @override
  State<ColorDots> createState() => _ColorDotsState();
}

class _ColorDotsState extends State<ColorDots> {
  int quantity = 1;
  late double productPrice;

  @override
  void initState() {
    super.initState();
    productPrice = widget.item.price!.toDouble();
  }

  void increaseQuantity() {
    setState(() {
      quantity++;
      productPrice = widget.item.price!.toDouble() * quantity;
    });
  }

  void decreaseQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
        productPrice = widget.item.price!.toDouble() * quantity;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    int selectedColor = 3; // Adjust this as needed

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              "\$ $productPrice",
              style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: CustomColors.purple),
            ),
          ),
          const Spacer(),
          RoundedIconBtn(
            icon: Icons.remove,
            press: decreaseQuantity,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              "$quantity",
              // style: Theme.of(context).textTheme.titleMedium,
              style: TextStyle(
                  color: CustomColors.purple,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ),
          RoundedIconBtn(
              icon: Icons.add, showShadow: true, press: increaseQuantity),
        ],
      ),
    );
  }
}

class RoundedIconBtn extends StatefulWidget {
  const RoundedIconBtn({
    Key? key,
    required this.icon,
    required this.press,
    this.showShadow = false,
  }) : super(key: key);

  final IconData icon;
  final GestureTapCancelCallback press;
  final bool showShadow;

  @override
  State<RoundedIconBtn> createState() => _RoundedIconBtnState();
}

class _RoundedIconBtnState extends State<RoundedIconBtn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      width: 32,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          if (widget.showShadow)
            const BoxShadow(
              offset: Offset(0, 6),
              blurRadius: 10,
              color: Color(0xFFE6E6E6),
            ),
        ],
      ),
      child: IconButton(
        icon: Icon(widget.icon),
        onPressed: widget.press,
        color: CustomColors.lightGreen,
        iconSize: 16,
      ),
    );
  }
}
