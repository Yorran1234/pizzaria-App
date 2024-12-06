import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://pizzaria-api.free.beeceptor.com";

  static Future<void> sendOrder(Map<String, dynamic> order) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/orders"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(order),
      );

      if (response.statusCode == 200) {
        print('Pedido enviado com sucesso: ${response.body}');
      } else {
        print('Falha ao enviar pedido: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro ao enviar pedido: $e');
    }
  }
}
