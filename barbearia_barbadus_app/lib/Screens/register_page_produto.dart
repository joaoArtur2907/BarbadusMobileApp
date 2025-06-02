import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Service/produto_service.dart';
import '../model/produto.dart';

class RegisterPageProduto extends StatefulWidget {
  const RegisterPageProduto({super.key});

  @override
  _RegisterPageProdutoState createState() => _RegisterPageProdutoState();
}

class _RegisterPageProdutoState extends State<RegisterPageProduto> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _imagemController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _precoController = TextEditingController();
  final ProdutoService _produtoService = ProdutoService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2F2D2E),
      appBar: AppBar(
        title: const Text('Cadastrar Produto',
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
              // Neme
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
                  hintText: 'Digite o nome do produto',
                  hintStyle: TextStyle(color: Colors.grey[600]),
                ),
                validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              const SizedBox(height: 20),

              // Descrcao
              Text(
                'Descrição',
                style: TextStyle(
                  color: Color(0xFFFCFFFC),
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _descricaoController,
                style: TextStyle(color: Color(0xFF2F2D2E)),
                maxLines: 3,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFFCFFFC),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Digite a descrição',
                  hintStyle: TextStyle(color: Colors.grey[600]),
                ),
                validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              const SizedBox(height: 20),

              // preco
              Text(
                'Preço',
                style: TextStyle(
                  color: Color(0xFFFCFFFC),
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _precoController,
                style: TextStyle(color: Color(0xFF2F2D2E)),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                ],
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFFCFFFC),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'R\$ 0,00',
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  prefixText: 'R\$ ',
                ),
                validator: (value) {
                  if (value!.isEmpty) return 'Campo obrigatório';
                  if (double.tryParse(value.replaceAll(',', '.')) == null) {
                    return 'Digite um valor válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              //  foto
              Text(
                'Imagem',
                style: TextStyle(
                  color: Color(0xFFFCFFFC),
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _imagemController,
                style: TextStyle(color: Color(0xFF2F2D2E)),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFFCFFFC),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Caminho da imagem',
                  hintStyle: TextStyle(color: Colors.grey[600]),
                ),
                validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              const SizedBox(height: 30),

              // salvar
              Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFF09BC8A),
                ),
                child: TextButton(
                  onPressed: _register,
                  child: const Text(
                    'CADASTRAR',
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
      try {
        final preco = double.parse(_precoController.text.replaceAll(',', '.'));
        final produto = Produto(
          nome: _nomeController.text,
          descricao: _descricaoController.text,
          imagem: _imagemController.text,
          preco: preco,
        );
        await _produtoService.registerProduto(produto);
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}