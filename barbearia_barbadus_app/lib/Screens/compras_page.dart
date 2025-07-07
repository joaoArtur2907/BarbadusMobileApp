import 'package:flutter/material.dart';
import '../model/compra.dart';
import '../model/compra_item.dart';
import '../Service/compra_service.dart';
import '../persistance/compraItem_dao.dart';

class ComprasPage extends StatefulWidget {
  const ComprasPage({super.key});

  @override
  State<ComprasPage> createState() => _ComprasPageState();
}

class _ComprasPageState extends State<ComprasPage> {
  final CompraService _compraService = CompraService();
  final CompraItemDao _compraItemDao = CompraItemDao();

  List<Compra> compras = [];
  Map<int, List<CompraItem>> itensPorCompra = {};

  @override
  void initState() {
    super.initState();
    _carregarCompras();
  }

  Future<void> _carregarCompras() async {
    final lista = await _compraService.listarCompras();

    final Map<int, List<CompraItem>> mapaItens = {};
    for (final compra in lista) {
      final itens = await _compraItemDao.listarItensPorCompra(compra.id!);
      mapaItens[compra.id!] = itens;
    }

    setState(() {
      compras = lista;
      itensPorCompra = mapaItens;
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
          final itens = itensPorCompra[compra.id] ?? [];

          return Card(
            margin:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                  const SizedBox(height: 12),
                  const Text(
                    'Itens:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  ...itens.map((item) => Text(
                    '${item.quantidade}x ${item.produtoNome} '
                        '(R\$ ${item.precoUnitario.toStringAsFixed(2)})',
                    style: const TextStyle(fontSize: 15),
                  )),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
