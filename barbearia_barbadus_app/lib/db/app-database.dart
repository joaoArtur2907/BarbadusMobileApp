import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDatabase {
  static final AppDatabase _instance = AppDatabase._internal();
  static Database? _database;

  factory AppDatabase() => _instance;
  AppDatabase._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(await getDatabasesPath(), 'barbadus_database.db');

    // await deleteDatabase(path);

    return openDatabase(
      path,
      version: 4,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE user(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nome TEXT,
          email TEXT,
          senha TEXT,
          isAdmin INTEGER DEFAULT 0
        )
        ''');

        await db.execute('''
        CREATE TABLE produto(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT,
        imagem TEXT,
        descricao TEXT,
        preco REAL
        )
        '''
        );

        await db.execute('''
        CREATE TABLE IF NOT EXISTS compra (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nomeComprador TEXT,
        endereco TEXT,
        total REAL
        );
        '''
        );

        await db.insert('user', {
          'nome': 'Administrador',
          'email': 'admin@gmail.com',
          'senha': '12345',
          'isAdmin': 1
        });

      }
    );
  }
}