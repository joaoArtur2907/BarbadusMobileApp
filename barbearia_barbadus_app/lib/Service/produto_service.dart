import 'package:barbearia_barbadus_app/db/app-database.dart';

import '../persistance/produto_dao.dart';
import '../model/produto.dart';

class ProdutoService {
  final ProdutoDao _produtoDao = ProdutoDao();

  Future<bool> registerProduto(Produto produto) async {
    try {
      await _produtoDao.insertProduto(produto);
      return true;
    } catch (e) {
      print('Erro ao registrar produto: $e');
      return false;
    }
  }

  Future<void> deleteProduto(int id) async {
    final db = await AppDatabase().database;
    await db.delete('produto', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> updateProduto(Produto produto) async {
    final db = await AppDatabase().database;
    await db.update(
      'produto',
      produto.toMap(),
      where: 'id = ?',
      whereArgs: [produto.id],
    );
  }



  Future<List<Produto>> getProdutos() async {
    return await _produtoDao.getAllProdutos();
  }
}