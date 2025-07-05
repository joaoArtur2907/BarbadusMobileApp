import 'package:flutter/material.dart';
import '../Service/auth_service.dart';
import '../model/user.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2F2D2E),
      appBar: AppBar(
        title: const Text('Registro',
            style: TextStyle(color: Color(0xFFFCFFFC))),
        backgroundColor: const Color(0xFF2F2D2E),
        iconTheme: const IconThemeData(color: Color(0xFF09BC8A)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Nome
              Text(
                'Nome',
                style: TextStyle(
                  color: Color(0xFFFCFFFC),
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _nomeController,
                style: TextStyle(color: Color(0xFF2F2D2E)),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFFCFFFC),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Digite seu nome',
                  hintStyle: TextStyle(color: Colors.grey[600]),
                ),
                validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              const SizedBox(height: 20),

              // Email
              Text(
                'Email',
                style: TextStyle(
                  color: Color(0xFFFCFFFC),
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _emailController,
                style: TextStyle(color: Color(0xFF2F2D2E)),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFFCFFFC),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Digite seu email',
                  hintStyle: TextStyle(color: Colors.grey[600]),
                ),
                validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              const SizedBox(height: 20),

              // Senha
              Text(
                'Senha',
                style: TextStyle(
                  color: Color(0xFFFCFFFC),
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _senhaController,
                obscureText: true,
                style: TextStyle(color: Color(0xFF2F2D2E)),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFFCFFFC),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Digite sua senha',
                  hintStyle: TextStyle(color: Colors.grey[600]),
                ),
                validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              const SizedBox(height: 30),
              
              // Botão de Registrar
              Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFF09BC8A),
                ),
                child: TextButton(
                  onPressed: _register,
                  child: const Text(
                    'REGISTRAR',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _register() async {
    if (_formKey.currentState!.validate()) {
      final user = User(
        nome: _nomeController.text,
        email: _emailController.text,
        senha: _senhaController.text,
      );
      final success = await _authService.register(user);
      if (success) {
        Navigator.pop(context);
      }
    }
  }
}