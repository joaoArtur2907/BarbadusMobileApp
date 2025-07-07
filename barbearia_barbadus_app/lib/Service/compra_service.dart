import 'package:barbearia_barbadus_app/db/app-database.dart';

import '../model/compra.dart';
import '../model/compra_item.dart';
import '../model/carrinho_item.dart';
import '../persistance/compra_dao.dart';
import '../persistance/compraItem_dao.dart';

class CompraService {
  final CompraDao _compraDao = CompraDao();
  final CompraItemDao _itemDao = CompraItemDao();

  Future<void> registrarCompra(Compra compra, List<CarrinhoItem> carrinho) async {
    final db = await AppDatabase().database;

    await db.transaction((txn) async {
      final compraId = await txn.insert('compra', compra.toMap());

      for (final item in carrinho) {
        final compraItem = CompraItem(
          compraId: compraId,
          produtoNome: item.produto.nome,
          quantidade: item.quantidade,
          precoUnitario: item.produto.preco,
        );

        await txn.insert('compra_item', compraItem.toMap());
      }
    });
  }

  Future<List<Compra>> listarCompras() async {
    return await _compraDao.listarCompras();
  }
}
