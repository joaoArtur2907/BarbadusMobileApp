import 'package:flutter/material.dart';
import '../model/compra.dart';
import '../Service/compra_service.dart';

class ComprasPage extends StatefulWidget {
  const ComprasPage({super.key});

  @override
  State<ComprasPage> createState() => _ComprasPageState();
}

class _ComprasPageState extends State<ComprasPage> {
  final CompraService _compraService = CompraService();
  List<Compra> compras = [];

  @override
  void initState() {
    super.initState();
    _carregarCompras();
  }

  Future<void> _carregarCompras() async {
    final lista = await _compraService.listarCompras();
    setState(() {
      compras = lista;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2F2D2E),
      appBar: AppBar(
        title: const Text('Compras Realizadas'),
        backgroundColor: const Color(0xFF2F2D2E),
        foregroundColor: Colors.white,
      ),
      body: compras.isEmpty
          ? const Center(
        child: Text(
          'Nenhuma compra registrada.',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      )
          : ListView.builder(
        itemCount: compras.length,
        itemBuilder: (context, index) {
          final compra = compras[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Comprador: ${compra.nomeComprador}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xFF2F2D2E),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Endereço: ${compra.endereco}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Total: R\$ ${compra.total.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
