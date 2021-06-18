import 'package:ecommerce_getx/model/cart_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CartDatabaseHelper {
  CartDatabaseHelper._();
  static final cartHelper = CartDatabaseHelper._();
  static String tableName = 'Cart';
  static String idColumn = 'id';
  static String imageColumn = 'image';
  static String nameColumn = 'name';
  static String quantityColumn = 'quantity';
  static String priceColumn = 'price';
  static Database? _database;
  Future<Database?> get database async {
    if (_database == null) _database = await openData();
    return _database;
  }

  Future<Database> openData() async {
    String path = join(await getDatabasesPath(), 'CartProduct.db');
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE $tableName ($idColumn TEXT, $nameColumn TEXT, $quantityColumn INTEGER, $priceColumn REAL,$imageColumn TEXT)');
    });
  }

  Future<CartModel> insert(CartModel cart) async {
    final db = await database;
    await db!.insert(tableName, cart.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    print('cart.id =${cart.id}');
    return cart;
  }

  Future<List<CartModel>> getAllProduct() async {
    final db = await database;
    var products = await db!.query(tableName);
    return products.length == 0
        ? []
        : products.map((cart) {
            return CartModel.fromMap(cart);
          }).toList();
  }

  Future<void> updateProduct(CartModel cart) async {
    final db = await database;
    await db!.update(tableName, cart.toMap(),
        where: '$idColumn = ?', whereArgs: [cart.id]);
    print('updated');
  }

  Future<int> delete(String id) async {
    final db = await database;

    return await db!.delete(tableName, where: '$idColumn = ?', whereArgs: [id]);
  }

  Future<int> deleteAll() async {
    final db = await database;

    return await db!.delete(tableName);
  }
}
