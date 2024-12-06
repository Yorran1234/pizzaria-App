import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../services/api_service.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Pedidos Finalizados')),
      body: cart.completedOrders.isEmpty
          ? const Center(
              child: Text(
                'Nenhum pedido finalizado!',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: cart.completedOrders.length,
              itemBuilder: (context, index) {
                final order = cart.completedOrders[index];
                final products = order['products'] as List;
                final total = order['total'] as double;
                final timestamp = order['timestamp'] as DateTime;

                // Processar o pedido para envio
                final processedOrder = {
                  ...order,
                  'timestamp': timestamp.toIso8601String(),
                };

                // Verificar e enviar o pedido
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (!order.containsKey('sent') || !order['sent']) {
                    ApiService.sendOrder(processedOrder).then((_) {
                      cart.markOrderAsSent(index);
                    }).catchError((e) {
                      print('Erro ao enviar pedido: $e');
                    });
                  }
                });

                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Colors.red,
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Cabeçalho com ícone e status
                          Row(
                            children: [
                              const Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: 24,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Pedido Finalizado',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),

                          // ID e tempo estimado
                          Text(
                            '#${order['id']}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Tempo aproximado',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '60min',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const Divider(color: Colors.white, thickness: 1),
                          const SizedBox(height: 10),

                          // Produtos do pedido
                          ...products.map(
                            (product) => Text(
                              '• ${product['name']}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),

                          const SizedBox(height: 10),

                          // Total
                          Text(
                            'Total: R\$${total.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
