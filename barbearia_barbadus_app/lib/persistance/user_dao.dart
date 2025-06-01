import '../model/user.dart';
import '../db/app-database.dart';

class UserDao{
  static const String table = 'user';

  Future<int> insertUser(User user) async{
    final db = await AppDatabase().database;
    return db.insert(table, user.toMap());
  }

  Future<User?> getUser(String email, String senha) async {
    final db = await AppDatabase().database;
    final result = await db.query(
      table,
      where: 'email = ? AND senha = ?',
      whereArgs: [email, senha],
    );
    return result.isNotEmpty ? User.fromMap(result.first) : null;
  }

}