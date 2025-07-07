import 'package:flutter/material.dart';
import '../model/produto.dart';
import '../Service/produto_service.dart';

class RegisterPageProduto extends StatefulWidget {
  final Produto? produtoEdit;

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
        await _produtoService.registerProduto(novoProduto);
      } else {
        await _produtoService.updateProduto(novoProduto);
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isEdicao = widget.produtoEdit != null;

    return Scaffold(
      backgroundColor: const Color(0xFF2F2D2E),
      appBar: AppBar(
        title: Text(isEdicao ? 'Editar Produto' : 'Cadastrar Produto'),
        backgroundColor: const Color(0xFF2F2D2E),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildInput(
                controller: _nomeController,
                label: 'Nome do produto',
                validator: (value) =>
                value == null || value.isEmpty ? 'Informe o nome' : null,
              ),
              const SizedBox(height: 16),
              _buildInput(
                controller: _imagemController,
                label: 'URL da imagem',
                validator: (value) =>
                value == null || value.isEmpty ? 'Informe a imagem' : null,
              ),
              const SizedBox(height: 16),
              _buildInput(
                controller: _descricaoController,
                label: 'Descrição',
                validator: (value) =>
                value == null || value.isEmpty ? 'Informe a descrição' : null,
              ),
              const SizedBox(height: 16),
              _buildInput(
                controller: _precoController,
                label: 'Preço',
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  final parsed = double.tryParse(value ?? '');
                  if (parsed == null || parsed <= 0) {
                    return 'Preço inválido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _salvarProduto,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF09BC8A),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  isEdicao ? 'Salvar Alterações' : 'Cadastrar Produto',
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInput({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: const Color(0xFF3E3E3E),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white38),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: validator,
    );
  }
}
