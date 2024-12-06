import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../models/pizza_model.dart';
import 'bebidas_screen.dart';
import 'orders_screen.dart';
import 'conta_screen.dart';
import 'pizzas_screen.dart';
import 'cart_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Pizza> pizzas = [
    Pizza(
      nome: "Portuguesa",
      descricao: "Presunto, milho, palmito, azeitona, ovo, cebola e orégano",
      imagem: "assets/images/portuguesa.png",
      precos: {"P": 32.0, "M": 45.0, "G": 70.0},
    ),
    Pizza(
      nome: "Calabresa",
      descricao: "Calabresa, cebola e orégano",
      imagem: "assets/images/calabresa.png",
      precos: {"P": 32.0, "M": 45.0, "G": 70.0},
    ),
    Pizza(
      nome: "Strogonoff Frango",
      descricao: "Strogonoff de frango, batata palha",
      imagem: "assets/images/strogonoff_frango.png",
      precos: {"P": 32.0, "M": 45.0, "G": 70.0},
    ),
    Pizza(
      nome: "Moda",
      descricao: "Presunto, tomate, mussarela, milho, bacon",
      imagem: "assets/images/moda.png",
      precos: {"P": 32.0, "M": 45.0, "G": 70.0},
    ),
  ];

  final List<Map<String, dynamic>> bebidas = [
    {
      "nome": "Coca-Cola",
      "descricao": "Refrigerante de cola 350ml",
      "imagem": "assets/images/coca_cola.png",
      "preco": 5.0,
    },
    {
      "nome": "Guaraná",
      "descricao": "Refrigerante de guaraná 350ml",
      "imagem": "assets/images/guarana.png",
      "preco": 4.5,
    },
    {
      "nome": "Suco de Laranja",
      "descricao": "Suco natural de laranja 300ml",
      "imagem": "assets/images/suco_laranja.png",
      "preco": 6.0,
    },
    {
      "nome": "Água Mineral",
      "descricao": "Água mineral sem gás 500ml",
      "imagem": "assets/images/agua.png",
      "preco": 3.0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final int cartItemCount =
        cart.totalItemCount; // Número total de itens no carrinho

    final tabs = [
      PizzasScreen(),
      BebidasPage(),
      OrdersScreen(),
      ContaScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon:
              const Icon(Icons.menu, color: Colors.red), // Ícone vermelho fixo
          onPressed: () {
            // Sem funcionalidade
          },
        ),
        title: Image.asset(
          'assets/images/logo.png',
          height: 100,
        ),
        centerTitle: true,
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart,
                    color: Colors.red), // Ícone vermelho fixo
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          CartScreen(pizzas: pizzas, bebidas: bebidas),
                    ),
                  );
                },
              ),
              if (cartItemCount > 0)
                Positioned(
                  right: 10,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      cartItemCount.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.red, // Ícone vermelho fixo
        selectedFontSize: 14,
        unselectedFontSize: 12,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.local_pizza),
            label: 'Pizzas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_drink),
            label: 'Bebidas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Pedidos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Conta',
          ),
        ],
      ),
    );
  }
}
