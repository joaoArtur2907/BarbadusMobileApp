import '../model/produto.dart';
import '../db/app-database.dart';

class ProdutoDao {
  static const String table = 'students';

  Future<int> insertProduto(Produto produto) async {
    final db = await AppDatabase().database;
    return db.insert(table, produto.toMap());
  }

  Future<List<Produto>> getAllProdutos() async {
    final db = await AppDatabase().database;
    final result = await db.query(table);
    return result.map((map) => Produto.fromMap(map)).toList();
  }


}