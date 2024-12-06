// lib/funcionalidades/home/home_page.dart

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.yellow[700],
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {},
      ),
      title: Image.asset(
        'lib/core/imagens/logo.png', // Certifique-se de ter a imagem do logo
        height: 50,
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.shopping_cart, color: Colors.red),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildPromoBanner(),
          _buildBalanceSection(),
          _buildPizzaList(),
        ],
      ),
    );
  }

  Widget _buildPromoBanner() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Image.asset(
            'lib/core/imagens/promo_banner.png', // Adicione uma imagem de promoção
            fit: BoxFit.cover,
            height: 150,
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceSection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Saldo',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text('R\$ 159,00', style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }

  Widget _buildPizzaList() {
    List<Map<String, dynamic>> pizzas = [
      {
        "name": "Portuguesa",
        "price": "R\$ 65",
        "description": "Presunto, milho, palmito...",
        "image": 'lib/core/imagens/portuguesa.png'
      },
      {
        "name": "Calabresa",
        "price": "R\$ 45",
        "description": "Presunto, tomate...",
        "image": 'lib/core/imagens/calabresa.png'
      },
      {
        "name": "Strogonoff Frango",
        "price": "R\$ 35",
        "description": "Mussarela e strogonoff...",
        "image": 'lib/core/imagens/strogonoff_frango.png'
      },
      {
        "name": "MODA",
        "price": "R\$ 45",
        "description": "Presunto, tomate...",
        "image": 'lib/core/imagens/moda.png'
      },
      {
        "name": "Strogonoff Carne",
        "price": "R\$ 35",
        "description": "Mussarela e strogonoff...",
        "image": 'lib/core/imagens/strogonoff_carne.png'
      },
    ];

    return Column(
      children: pizzas.map((pizza) => _buildPizzaCard(pizza)).toList(),
    );
  }

  Widget _buildPizzaCard(Map<String, dynamic> pizza) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  pizza["image"],
                  width: 60,
                  height: 60,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pizza["name"],
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(pizza["description"]),
                  ],
                ),
                const Spacer(),
                Text(
                  pizza["price"],
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSizeOptions(),
                _buildAddToCartButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSizeOptions() {
    return Row(
      children: [
        _buildSizeButton('Pequena'),
        _buildSizeButton('Média'),
        _buildSizeButton('Grande'),
      ],
    );
  }

  Widget _buildSizeButton(String size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.red,
          backgroundColor: Colors.white,
          side: const BorderSide(color: Colors.red),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        child: Text(size),
      ),
    );
  }

  Widget _buildAddToCartButton() {
    return IconButton(
      icon: const Icon(Icons.add_shopping_cart, color: Colors.red),
      onPressed: () {},
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.menu),
          label: 'Menu',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_drink),
          label: 'Bebidas',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.check_circle),
          label: 'Finalizar',
        ),
      ],
      selectedItemColor: Colors.red,
      unselectedItemColor: Colors.grey,
    );
  }
}
