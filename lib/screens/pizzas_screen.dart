import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/pizza_model.dart';
import '../providers/cart_provider.dart';

class PizzasScreen extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return ListView.builder(
      itemCount: pizzas.length,
      itemBuilder: (context, index) {
        final pizza = pizzas[index];
        return Card(
          margin: const EdgeInsets.all(10),
          elevation: 5,
          child: Column(
            children: [
              ListTile(
                leading: Image.asset(pizza.imagem, width: 80, height: 80),
                title: Text(
                  pizza.nome,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(pizza.descricao),
                trailing: Text(
                  'R\$ ${pizza.precos["M"]!.toStringAsFixed(2)}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: pizza.precos.keys.map((tamanho) {
                  return Column(
                    children: [
                      Text(
                        tamanho,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'R\$ ${pizza.precos[tamanho]!.toStringAsFixed(2)}',
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () =>
                                cart.removerDoCarrinho(pizza.nome, tamanho),
                            icon: const Icon(Icons.remove),
                            color: Colors.red,
                          ),
                          Text(
                            '${cart.carrinho[pizza.nome]?[tamanho] ?? 0}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            onPressed: () =>
                                cart.adicionarAoCarrinho(pizza.nome, tamanho),
                            icon: const Icon(Icons.add),
                            color: Colors.green,
                          ),
                        ],
                      ),
                    ],
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}
