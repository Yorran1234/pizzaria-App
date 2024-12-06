import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.red,
            ),
          );
        }

        if (!snapshot.hasData) {
          return const Center(child: Text('Erro ao carregar os dados.'));
        }

        final prefs = snapshot.data!;
        final name = prefs.getString('name') ?? 'Não informado';
        final email = prefs.getString('email') ?? 'Não informado';
        final phone = prefs.getString('phone') ?? 'Não informado';
        final address = prefs.getString('address') ?? 'Não informado';
        final cep = prefs.getString('cep') ?? 'Não informado';
        final city = prefs.getString('city') ?? 'Não informado';

        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 40, // Reduzido o tamanho
                          backgroundColor: Colors.grey[300],
                          child: const Icon(
                            Icons.person,
                            size: 40, // Reduzido para acompanhar o avatar
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 6), // Diminuído o espaçamento
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 18, // Um pouco menor
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16), // Reduzido o espaçamento

                  // Card para Dados Pessoais
                  _buildFullWidthCard(
                    context,
                    children: [
                      _buildSectionTitle('Dados Pessoais'),
                      _buildInfoText('Usuário: ${email.split('@').first}'),
                      _buildInfoText('E-mail: $email'),
                      _buildInfoText('Telefone: $phone'),
                    ],
                  ),

                  const SizedBox(height: 12), // Reduzido o espaçamento

                  // Card para Dados de Entrega
                  _buildFullWidthCard(
                    context,
                    children: [
                      _buildSectionTitle('Dados de Entrega'),
                      _buildInfoText('Endereço: $address'),
                      _buildInfoText('CEP: $cep'),
                      _buildInfoText('Cidade: $city'),
                    ],
                  ),

                  const SizedBox(height: 20), // Reduzido o espaçamento

                  // Botão Sair
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.clear();
                        Navigator.of(context).pushReplacementNamed('/login');
                      },
                      icon: const Icon(Icons.logout, color: Colors.black),
                      label: const Text(
                        'Sair',
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16, // Menor padding
                          vertical: 6,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFullWidthCard(BuildContext context,
      {required List<Widget> children}) {
    return Card(
      elevation: 4, // Leve redução na sombra
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), // Bordas levemente menores
      ),
      margin: const EdgeInsets.symmetric(horizontal: 12), // Margem reduzida
      child: Container(
        width: double.infinity, // Garante a largura total
        padding: const EdgeInsets.all(12.0), // Reduzido o padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0), // Menor espaçamento
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16, // Menor tamanho
          fontWeight: FontWeight.bold,
          color: Colors.red,
        ),
      ),
    );
  }

  Widget _buildInfoText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0), // Menor espaçamento
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14, // Menor tamanho
          fontWeight: FontWeight.normal,
        ),
        textAlign: TextAlign.left,
      ),
    );
  }
}
