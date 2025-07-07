import 'package:sqflite/sqflite.dart';
import '../model/compra_item.dart';
import '../db/app-database.dart';

class CompraItemDao {
  Future<void> inserirItem(CompraItem item) async {
    final db = await AppDatabase().database;
    await db.insert('compra_item', item.toMap());
  }

  Future<List<CompraItem>> listarItensPorCompra(int compraId) async {
    final db = await AppDatabase().database;
    final maps = await db.query(
      'compra_item',
      where: 'compra_id = ?',
      whereArgs: [compraId],
    );
    return maps.map((e) => CompraItem.fromMap(e)).toList();
  }
}
