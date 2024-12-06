// lib/funcionalidades/autenticacao/cadastro_page.dart

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  // Controladores de texto para capturar entrada do usuário
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController telefoneController = TextEditingController();
  final TextEditingController enderecoController = TextEditingController();
  final TextEditingController cepController = TextEditingController();
  final TextEditingController cidadeController = TextEditingController();

  // Função para processar o cadastro
  Future<void> _finalizarCadastro() async {
    final email = emailController.text;
    final senha = senhaController.text;
    final nome = nomeController.text;
    final telefone = telefoneController.text;
    final endereco = enderecoController.text;
    final cep = cepController.text;
    final cidade = cidadeController.text;

    final url =
        Uri.parse('https://fornoesaborlogin.free.beeceptor.com/user/register');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'senha': senha,
          'nome': nome,
          'telefone': telefone,
          'endereco': endereco,
          'cep': cep,
          'cidade': cidade,
        }),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cadastro realizado com sucesso!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro no cadastro: ${response.statusCode}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro na conexão: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'Cadastro de Usuário',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildTextField('Nome Completo', nomeController, Icons.person),
            const SizedBox(height: 16),
            _buildTextField('Email', emailController, Icons.email_outlined),
            const SizedBox(height: 16),
            _buildTextField('Telefone', telefoneController, Icons.phone),
            const SizedBox(height: 16),
            _buildTextField('Endereço', enderecoController, Icons.home),
            const SizedBox(height: 16),
            _buildTextField('CEP', cepController, Icons.location_on),
            const SizedBox(height: 16),
            _buildTextField('Cidade', cidadeController, Icons.location_city),
            const SizedBox(height: 16),
            _buildTextField('Senha', senhaController, Icons.lock_outline,
                obscureText: true),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _finalizarCadastro,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding:
                    const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                "Finalizar Cadastro",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Função auxiliar para construir campos de texto
  Widget _buildTextField(
      String hintText, TextEditingController controller, IconData icon,
      {bool obscureText = false}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(icon),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
