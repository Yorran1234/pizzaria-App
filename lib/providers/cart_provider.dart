import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/pizza_model.dart';

class CartProvider with ChangeNotifier {
  final List<Product> _items = []; // Produtos genéricos
  final Map<String, Map<String, int>> _carrinho = {}; // Carrinho com tamanhos
  final List<Map<String, dynamic>> _completedOrders =
      []; // Lista de pedidos finalizados

  // Getters
  List<Product> get items => _items;
  Map<String, Map<String, int>> get carrinho => _carrinho;
  List<Map<String, dynamic>> get completedOrders => _completedOrders;

  // Total para produtos genéricos
  double get totalPriceProducts =>
      _items.fold(0.0, (sum, item) => sum + item.price);

  // Total para pizzas
  double calcularTotalPizzas(List<Pizza> pizzas) {
    double total = 0;
    _carrinho.forEach((nome, tamanhos) {
      final pizza = pizzas
          .firstWhereOrNull((p) => p.nome == nome); // Usa `firstWhereOrNull`
      if (pizza != null) {
        tamanhos.forEach((tamanho, quantidade) {
          total += (pizza.precos[tamanho]! * quantidade);
        });
      }
    });
    return total;
  }

  // Número total de itens no carrinho
  int get totalItemCount {
    int totalProdutosGenericos = _items.length; // Conta os produtos genéricos
    int totalPizzas = _carrinho.values.fold(0, (total, tamanhos) {
      return total +
          tamanhos.values
              .fold(0, (subtotal, quantidade) => subtotal + quantidade);
    });

    return totalProdutosGenericos + totalPizzas;
  }

  // Adicionar produtos genéricos
  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }

  // Remover produtos genéricos
  void removeProduct(Product product) {
    _items.remove(product);
    notifyListeners();
  }

  // Limpar produtos genéricos
  void clearGenericCart() {
    _items.clear();
    notifyListeners();
  }

  // Adicionar pizza ao carrinho
  void adicionarAoCarrinho(String nome, String tamanho) {
    if (!_carrinho.containsKey(nome)) {
      _carrinho[nome] = {"P": 0, "M": 0, "G": 0};
    }
    _carrinho[nome]![tamanho] = (_carrinho[nome]![tamanho] ?? 0) + 1;
    notifyListeners();
  }

  // Remover pizza do carrinho
  void removerDoCarrinho(String nome, String tamanho) {
    if (_carrinho.containsKey(nome) && _carrinho[nome]![tamanho]! > 0) {
      _carrinho[nome]![tamanho] = _carrinho[nome]![tamanho]! - 1;

      // Remove a pizza se todos os tamanhos forem 0
      if (_carrinho[nome]!.values.every((qtd) => qtd == 0)) {
        _carrinho.remove(nome);
      }

      notifyListeners();
    }
  }

  // Limpar carrinho de pizzas
  void clearPizzaCart() {
    _carrinho.clear();
    notifyListeners();
  }

  // Finalizar pedido genérico e de pizzas
  void finalizeOrder(List<Pizza> pizzas) {
    final totalPizzas = calcularTotalPizzas(pizzas);
    final totalProdutos = totalPriceProducts;
    final total = totalPizzas + totalProdutos;

    if (_items.isNotEmpty || _carrinho.isNotEmpty) {
      _completedOrders.add({
        'products': List<Product>.from(_items), // Clona os itens
        'pizzas':
            Map<String, Map<String, int>>.from(_carrinho), // Clona o carrinho
        'total': total,
        'timestamp': DateTime.now(),
        'sent': false, // Marca o pedido como não enviado
      });

      clearGenericCart();
      clearPizzaCart();
      notifyListeners();
    }
  }

  // Marcar pedido como enviado
  void markOrderAsSent(int index) {
    if (index >= 0 && index < _completedOrders.length) {
      _completedOrders[index]['sent'] = true;
      notifyListeners();
    }
  }
}

// Extensão para adicionar o `firstWhereOrNull`, útil em coleções
extension FirstWhereOrNullExtension<E> on Iterable<E> {
  E? firstWhereOrNull(bool Function(E element) test) {
    for (var element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}
