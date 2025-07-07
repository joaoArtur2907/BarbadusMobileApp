import 'package:flutter/material.dart';
import '../model/produto.dart';
import '../model/carrinho_item.dart';
import '../model/user.dart';
import '../model/compra.dart';
import '../Service/compra_service.dart';

class CarrinhoPage extends StatefulWidget {
  final List<CarrinhoItem> carrinho;
  final User user;

  const CarrinhoPage({super.key, required this.carrinho, required this.user});

  @override
  State<CarrinhoPage> createState() => _CarrinhoPageState();
}

class _CarrinhoPageState extends State<CarrinhoPage> {
  final TextEditingController _enderecoController = TextEditingController();
  final CompraService _compraService = CompraService();

  void _finalizarCompra() async {
    if (_enderecoController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, insira o endereço de entrega.')),
      );
      return;
    }

    final compra = Compra(
      nomeComprador: widget.user.nome,
      endereco: _enderecoController.text,
      total: _precoTotal,
    );

    await _compraService.registrarCompra(compra, widget.carrinho);

    setState(() {
      widget.carrinho.clear();
      _enderecoController.clear();
    });

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Compra bem sucedida!'),
        content: Text('Entrega para: ${compra.endereco}'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          )
        ],
      ),
    );
  }

  double get _precoTotal {
    return widget.carrinho.fold(0, (soma, item) => soma + item.total);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2F2D2E),
      appBar: AppBar(
        backgroundColor: Color(0xFF2F2D2E),
        elevation: 0,
        title: const Text(
          'CARRINHO',
          style: TextStyle(
            color: Color(0xFFFCFFFC),
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (widget.carrinho.isEmpty)
              Expanded(
                child: Center(
                  child: Text(
                    'Seu carrinho está vazio',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: widget.carrinho.length,
                  itemBuilder: (context, index) {
                    final item = widget.carrinho[index];
                    return Card(
                      color: Color(0xFFFCFFFC),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: EdgeInsets.only(bottom: 12),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.produto.nome,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF2F2D2E),
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'R\$ ${item.total.toStringAsFixed(2)}',
                                    style: TextStyle(color: Color(0xFF2F2D2E)),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.remove),
                                  color: Colors.black,
                                  onPressed: () {
                                    setState(() {
                                      if (item.quantidade > 1) {
                                        item.quantidade--;
                                      } else {
                                        widget.carrinho.removeAt(index);
                                      }
                                    });
                                  },
                                ),
                                Text(
                                  '${item.quantidade}',
                                  style: TextStyle(fontSize: 16),
                                ),
                                IconButton(
                                  icon: Icon(Icons.add),
                                  color: Colors.black,
                                  onPressed: () {
                                    setState(() {
                                      item.quantidade++;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            SizedBox(height: 10),
            TextField(
              controller: _enderecoController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Endereço de entrega',
                labelStyle: TextStyle(color: Colors.white70),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white38),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 15),
            Text(
              'Total: R\$ ${_precoTotal.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 22,
                color: Color(0xFFFCFFFC),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _finalizarCompra,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF09BC8A),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: Text(
                'FINALIZAR COMPRA',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
