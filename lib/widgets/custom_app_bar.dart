import 'package:flutter/material.dart';
import '../providers/cart_provider.dart';
import '../models/pizza_model.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Pizza> pizzas;
  final CartProvider cart;
  final VoidCallback onCartPressed;
  final Widget? titleWidget; // Novo parâmetro opcional

  const CustomAppBar({
    Key? key,
    required this.pizzas,
    required this.cart,
    required this.onCartPressed,
    this.titleWidget, // Novo parâmetro opcional
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.red,
      title: titleWidget ?? const Text('Pizzaria'), // Usa logo ou texto padrão
      centerTitle: true,
      actions: [
        IconButton(
          icon: Stack(
            clipBehavior: Clip.none,
            children: [
              const Icon(Icons.shopping_cart),
              if (cart.items.isNotEmpty)
                Positioned(
                  right: -5,
                  top: -5,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.yellow,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      cart.items.length.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          onPressed: onCartPressed,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
