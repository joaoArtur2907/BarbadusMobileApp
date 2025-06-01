import 'package:barbearia_barbadus_app/Screens/register_page.dart'; // Certifique-se de importar sua RegisterPage
import 'package:barbearia_barbadus_app/Screens/homePage.dart';
import 'package:barbearia_barbadus_app/Service/auth_service.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final AuthService _authService = AuthService();

  void _login() async {
    if (_formKey.currentState!.validate()) {
      final user = await _authService.login(
        _emailController.text,
        _senhaController.text,
      );
      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const homePage()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2F2D2E),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Logo
              Padding(
                padding: const EdgeInsets.only(top: 60.0, bottom: 10),
                child: Center(
                  child: Container(
                    width: 200,
                    height: 150,
                    child: const Icon(Icons.icecream_sharp, size: 80),
                  ),
                ),
              ),

              // Form Container
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 105, vertical: 10),
                padding: const EdgeInsets.only(left: 25, right: 25, top: 40, bottom: 25),
                width: 500,
                decoration: BoxDecoration(
                  color: const Color(0xFFFCFFFC),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    // Email Field
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Email',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 22,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0, color: Colors.black87),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0, color: Colors.black38),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0, color: Colors.black),
                        ),
                        hintText: 'seu@email.com',
                      ),
                      validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
                    ),
                    const SizedBox(height: 20),

                    // Password Field
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Senha',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 22,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _senhaController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0, color: Colors.black87),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0, color: Colors.black38),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0, color: Colors.black),
                        ),
                        hintText: '********',
                      ),
                      validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
                    ),
                    const SizedBox(height: 20),

                    // Login Button
                    Container(
                      height: 50,
                      width: 220,
                      decoration: BoxDecoration(
                        color: const Color(0xFF09BC8A),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextButton(
                        onPressed: _login,
                        child: const Text(
                          'Entrar',
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Botão "Criar conta" - ADICIONADO AQUI
                    TextButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RegisterPage()),
                      ),
                      child: const Text(
                        'Criar nova conta',
                        style: TextStyle(
                          color: Color(0xFF2F2D2E),
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 90),
            ],
          ),
        ),
      ),
    );
  }
}