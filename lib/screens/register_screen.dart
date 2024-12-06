import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart'; // Já está importado
import 'package:flutter/services.dart'; // Adiciona esta linha para garantir que TextInputFormatter seja reconhecido
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _cepController = TextEditingController();
  final _cityController = TextEditingController();
  bool _isPasswordVisible = false;

  Future<void> _register() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', _emailController.text);
    await prefs.setString('name', _nameController.text);
    await prefs.setString('password', _passwordController.text);
    await prefs.setString('phone', _phoneController.text);
    await prefs.setString('address', _addressController.text);
    await prefs.setString('cep', _cepController.text);
    await prefs.setString('city', _cityController.text);

    Navigator.pop(context); // Volta para a tela de login
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Imagem de fundo
          Positioned.fill(
            child: Image.asset(
              'assets/images/pizza_background.jpg',
              fit: BoxFit.cover,
            ),
          ),
          // Conteúdo principal
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                // Botão de voltar
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                // Logotipo
                Image.asset(
                  'assets/images/logo.png',
                  height: 100, // Menor altura para logotipo
                ),
                const SizedBox(height: 10),
                // Caixa de criar conta
                Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        "Crie sua conta",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildTextField('Email', false, _emailController),
                      const SizedBox(height: 16),
                      _buildTextField('Nome Completo', false, _nameController),
                      const SizedBox(height: 16),
                      _buildTextField('Senha', true, _passwordController),
                      const SizedBox(height: 16),
                      _buildMaskedTextField('Número de Telefone',
                          _phoneController, PhoneInputFormatter()),
                      const SizedBox(height: 16),
                      _buildTextField('Endereço', false, _addressController),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: _buildTextField('CEP', false,
                                _cepController), // Removido o formatter para o CEP
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            flex: 3,
                            child: _buildTextField(
                                'Cidade', false, _cityController),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _register,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text(
                          "FINALIZAR CADASTRO",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
      String hintText, bool isPassword, TextEditingController controller) {
    return TextField(
      controller: controller,
      obscureText: isPassword && !_isPasswordVisible,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.white.withOpacity(0.2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white70,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              )
            : null,
      ),
      style: const TextStyle(color: Colors.white),
    );
  }

  Widget _buildMaskedTextField(String hintText,
      TextEditingController controller, TextInputFormatter formatter) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [formatter],
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.white.withOpacity(0.2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
      ),
      style: const TextStyle(color: Colors.white),
    );
  }
}
