import 'package:sqflite/sqflite.dart';
import '../model/compra.dart';
import '../db/app-database.dart';

class CompraDao {
  Future<void> inserirCompra(Compra compra) async {
    final db = await AppDatabase().database;
    await db.insert('compra', compra.toMap());
  }

  Future<List<Compra>> listarCompras() async {
    final db = await AppDatabase().database;
    final maps = await db.query('compra', orderBy: 'id DESC');
    return maps.map((map) => Compra.fromMap(map)).toList();
  }
}
