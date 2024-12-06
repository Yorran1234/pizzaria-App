import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class BebidasPage extends StatelessWidget {
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

    return ListView.builder(
      itemCount: bebidas.length,
      itemBuilder: (context, index) {
        final bebida = bebidas[index];
        return Card(
          margin: const EdgeInsets.all(10),
          elevation: 5,
          child: Column(
            children: [
              ListTile(
                leading: Image.asset(bebida['imagem'], width: 80, height: 80),
                title: Text(
                  bebida['nome'],
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(bebida['descricao']),
                trailing: Text(
                  'R\$ ${bebida['preco'].toStringAsFixed(2)}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0, bottom: 8.0),
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.end, // Alinhado à direita
                  children: [
                    IconButton(
                      onPressed: () =>
                          cart.removerDoCarrinho(bebida['nome'], "M"),
                      icon: const Icon(Icons.remove),
                      color: Colors.red,
                    ),
                    Text(
                      '${cart.carrinho[bebida['nome']]?["M"] ?? 0}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      onPressed: () =>
                          cart.adicionarAoCarrinho(bebida['nome'], "M"),
                      icon: const Icon(Icons.add),
                      color: Colors.green,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
