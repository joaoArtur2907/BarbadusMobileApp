import 'package:flutter/material.dart';
import '../model/produto.dart';
import '../Service/produto_service.dart';

class RegisterPageProduto extends StatefulWidget {
  final Produto? produtoEdit; // Se for null, está criando um novo produto

  const RegisterPageProduto({super.key, this.produtoEdit});

  @override
  State<RegisterPageProduto> createState() => _RegisterPageProdutoState();
}

class _RegisterPageProdutoState extends State<RegisterPageProduto> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _imagemController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _precoController = TextEditingController();

  final ProdutoService _produtoService = ProdutoService();

  @override
  void initState() {
    super.initState();

    if (widget.produtoEdit != null) {
      _nomeController.text = widget.produtoEdit!.nome;
      _imagemController.text = widget.produtoEdit!.imagem;
      _descricaoController.text = widget.produtoEdit!.descricao;
      _precoController.text = widget.produtoEdit!.preco.toString();
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _imagemController.dispose();
    _descricaoController.dispose();
    _precoController.dispose();
    super.dispose();
  }

  Future<void> _salvarProduto() async {
    if (_formKey.currentState!.validate()) {
      final novoProduto = Produto(
        id: widget.produtoEdit?.id,
        nome: _nomeController.text.trim(),
        imagem: _imagemController.text.trim(),
        descricao: _descricaoController.text.trim(),
        preco: double.tryParse(_precoController.text) ?? 0,
      );

      if (widget.produtoEdit == null) {
        // Cadastro novo
        await _produtoService.registerProduto(novoProduto);
      } else {
        // Edição existente
        await _produtoService.updateProduto(novoProduto);
      }

      Navigator.pop(context); // Volta para tela anterior
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isEdicao = widget.produtoEdit != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdicao ? 'Editar Produto' : 'Cadastrar Produto'),
        backgroundColor: Color(0xFF2F2D2E),
        foregroundColor: Colors.white,
      ),
      backgroundColor: Color(0xFFFCFFFC),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(labelText: 'Nome do produto'),
                validator: (value) =>
                value == null || value.isEmpty ? 'Informe o nome' : null,
              ),
              TextFormField(
                controller: _imagemController,
                decoration: InputDecoration(labelText: 'URL da imagem'),
                validator: (value) =>
                value == null || value.isEmpty ? 'Informe a imagem' : null,
              ),
              TextFormField(
                controller: _descricaoController,
                decoration: InputDecoration(labelText: 'Descrição'),
                validator: (value) =>
                value == null || value.isEmpty ? 'Informe a descrição' : null,
              ),
              TextFormField(
                controller: _precoController,
                decoration: InputDecoration(labelText: 'Preço'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  final parsed = double.tryParse(value ?? '');
                  if (parsed == null || parsed <= 0) {
                    return 'Preço inválido';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _salvarProduto,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF09BC8A),
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  isEdicao ? 'Salvar Alterações' : 'Cadastrar Produto',
                  style: TextStyle(fontSize: 16),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
