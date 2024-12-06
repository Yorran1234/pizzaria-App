import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../models/pizza_model.dart';
import 'home_screen.dart'; // Certifique-se de que o caminho está correto

class PaymentScreen extends StatefulWidget {
  final List<Pizza> pizzas;

  PaymentScreen({required this.pizzas});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String _selectedPaymentMethod = 'Cartão de crédito / débito';
  bool _isDelivery = false;

  void _selectPaymentMethod(String method) {
    setState(() {
      _selectedPaymentMethod = method;
    });
  }

  void _toggleDeliveryOption(bool isDelivery) {
    setState(() {
      _isDelivery = isDelivery;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final totalProducts = cart.totalPriceProducts;
    final totalPizzas = cart.calcularTotalPizzas(widget.pizzas);
    final totalPrice = totalProducts + totalPizzas;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagamento'),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  _buildOrderSummary(cart, totalPrice),
                  const SizedBox(height: 20),
                  const Text(
                    'Sua forma de pagamento:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  _buildPaymentOption(
                    'Cartão de crédito / débito',
                    Icons.credit_card,
                    _selectedPaymentMethod == 'Cartão de crédito / débito',
                    () => _selectPaymentMethod('Cartão de crédito / débito'),
                  ),
                  _buildPaymentOption(
                    'PIX',
                    Icons.qr_code,
                    _selectedPaymentMethod == 'PIX',
                    () => _selectPaymentMethod('PIX'),
                  ),
                  _buildPaymentOption(
                    'Saldo da conta',
                    Icons.account_balance_wallet,
                    _selectedPaymentMethod == 'Saldo da conta',
                    () => _selectPaymentMethod('Saldo da conta'),
                  ),
                  _buildPaymentOption(
                    'Carteira do Google',
                    Icons.wallet,
                    _selectedPaymentMethod == 'Carteira do Google',
                    () => _selectPaymentMethod('Carteira do Google'),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Entrega:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  _buildDeliveryOption(
                    'Retirar na loja',
                    !_isDelivery,
                    () => _toggleDeliveryOption(false),
                  ),
                  _buildDeliveryOption(
                    'Entregar no endereço',
                    _isDelivery,
                    () => _toggleDeliveryOption(true),
                    address:
                        'Av. Presidente Vargas, 1235 - Centro\nCEP: 72550-652\nCidade: Rio Verde-GO',
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                cart.finalizeOrder(widget.pizzas);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        'Pedido finalizado com sucesso! Forma de pagamento: $_selectedPaymentMethod'),
                  ),
                );
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                  (Route<dynamic> route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                backgroundColor: Colors.red,
              ),
              child: const Text(
                'Finalizar Pedido',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummary(CartProvider cart, double totalPrice) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Itens no Pedido:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        ...cart.items.map(
          (product) => ListTile(
            leading: const Icon(Icons.fastfood),
            title: Text(product.name),
            trailing: Text('R\$${product.price.toStringAsFixed(2)}'),
          ),
        ),
        ...cart.carrinho.entries.map((entry) {
          final pizzaName = entry.key;
          final pizzaSizes = entry.value;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                pizzaName,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              ...pizzaSizes.entries.map((sizeEntry) {
                final size = sizeEntry.key;
                final quantity = sizeEntry.value;
                if (quantity > 0) {
                  final pizza = widget.pizzas
                      .firstWhere((pizza) => pizza.nome == pizzaName);
                  final price = pizza.precos[size]! * quantity;
                  return ListTile(
                    title: Text('Tamanho $size: $quantity'),
                    trailing: Text('R\$${price.toStringAsFixed(2)}'),
                  );
                }
                return const SizedBox.shrink();
              }),
            ],
          );
        }),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Total:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'R\$${totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPaymentOption(
      String title, IconData icon, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.red.withOpacity(0.2) : Colors.white,
          border: Border.all(
            color: isSelected ? Colors.red : Colors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? Colors.red : Colors.grey),
            const SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.red : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeliveryOption(String title, bool isSelected, VoidCallback onTap,
      {String? address}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.red.withOpacity(0.2) : Colors.white,
          border: Border.all(
            color: isSelected ? Colors.red : Colors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.location_on,
                    color: isSelected ? Colors.red : Colors.grey),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.red : Colors.black,
                  ),
                ),
              ],
            ),
            if (isSelected && address != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 30.0),
                child: Text(
                  address,
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
