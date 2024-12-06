import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/pizza_model.dart';
import '../providers/cart_provider.dart';
import 'payment_screen.dart';

class CartScreen extends StatelessWidget {
  final List<Pizza> pizzas;
  final List<Map<String, dynamic>> bebidas;

  CartScreen({required this.pizzas, required this.bebidas});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          // Área da lista
          Expanded(
            child: cart.carrinho.isEmpty && cart.items.isEmpty
                ? const Center(child: Text("Seu carrinho está vazio!"))
                : ListView(
                    children: [
                      // Exibe pizzas no carrinho
                      ...cart.carrinho.entries.map((entry) {
                        final nome = entry.key;
                        final tamanhos = entry.value;

                        final pizza = pizzas.firstWhereOrNull(
                          (p) => p.nome == nome,
                        );

                        return Card(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: tamanhos.entries
                                .where((e) => e.value > 0)
                                .map((tamanhoEntry) {
                              final tamanho = tamanhoEntry.key;
                              final quantidade = tamanhoEntry.value;
                              final preco = pizza?.precos[tamanho] ?? 0.0;

                              return ListTile(
                                leading: pizza?.imagem != null
                                    ? Image.asset(
                                        pizza!.imagem,
                                        width: 50,
                                        height: 50,
                                      )
                                    : const Icon(Icons.local_pizza),
                                title: Text(
                                  '${pizza?.nome ?? 'Pizza não encontrada'} - $tamanho',
                                ),
                                subtitle: Text(
                                  'Qtd: $quantidade',
                                ),
                                trailing: Text(
                                  'R\$ ${(preco * quantidade).toStringAsFixed(2)}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              );
                            }).toList(),
                          ),
                        );
                      }).toList(),

                      // Exibe bebidas no carrinho
                      ...cart.items.map((product) {
                        final bebida = bebidas.firstWhere(
                          (b) => b['nome'] == product.name,
                          orElse: () => {
                            'nome': product.name,
                            'descricao': 'Bebida não encontrada',
                            'preco': 0.0,
                            'imagem': null,
                          },
                        );

                        return Card(
                          child: ListTile(
                            leading: bebida['imagem'] != null
                                ? Image.asset(
                                    bebida['imagem'],
                                    width: 50,
                                    height: 50,
                                  )
                                : const Icon(Icons.local_drink),
                            title: Text(bebida['nome']),
                            subtitle: Text(bebida['descricao']),
                            trailing: Text(
                              'R\$ ${bebida['preco'].toStringAsFixed(2)}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        );
                      }).toList(),
                    ],
                  ),
          ),

          // Área de total e botões
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Total: R\$ ${_calcularTotal(cart).toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (cart.items.isEmpty && cart.carrinho.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('O carrinho está vazio!')),
                        );
                        return;
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PaymentScreen(pizzas: pizzas),
                        ),
                      );
                    },
                    child: const Text('Ir para o Pagamento'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: const Text(
                      'Adicionar Mais Itens',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  double _calcularTotal(CartProvider cart) {
    final totalPizzas = cart.calcularTotalPizzas(pizzas);
    final totalProdutos = cart.totalPriceProducts;

    // Adiciona o total das bebidas
    final totalBebidas = cart.items.fold(0.0, (sum, product) {
      final bebida = bebidas.firstWhere(
        (b) => b['nome'] == product.name,
        orElse: () => {'preco': 0.0},
      );
      return sum + bebida['preco'];
    });

    return totalProdutos + totalPizzas + totalBebidas;
  }
}
