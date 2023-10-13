
import 'package:helpershop/data/model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDatabase {
  static final LocalDatabase getInstance = LocalDatabase._init();
  static Database? _database;

  factory LocalDatabase() {
    return getInstance;
  }

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDB("SalesHelper.db");
      return _database!;
    }
  }

  Future<Database> _initDB(String dbName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);
    return await openDatabase(path, version: 1, onCreate: (db, ver) async {
      String idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
      String textType = "TEXT";

      await db.execute('''
    CREATE TABLE $tableName (
    ${ProductFields.id} $idType,
    ${ProductFields.code} $textType,
    ${ProductFields.count} $textType
    )
    ''');
    });
  }

  LocalDatabase._init();

  static Future<ProductModel> addProduct(
      ProductModel productModel) async {
    final db = await getInstance.database;
    final id = await db.insert(tableName, productModel.toJson());
    print('Hit qildi shu Producccct ham,');

    return productModel.copyWith(id: id);
  }

  static Future<List<ProductModel>> getAllProducts() async {
    final db = await getInstance.database;
    final result =
    await db.query(tableName, columns: ProductFields.values);
    print('Hit qildi shu Product ham keldi,');

    return result.map((json) => ProductModel.fromJson(json)).toList();
  }

  static Future<int> deleteAllProduct() async {
    final db = await getInstance.database;
    return await db.delete(tableName);
  }

  static Future close() async {
    final db = await getInstance.database;
    db.close();
  }
}