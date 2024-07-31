import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/product.dart';

Future<Database> getDatabase() async {
  final database =
      openDatabase(join(await getDatabasesPath(), 'bkap_database.db'),
          onCreate: (db, version) {
    return db.execute(
        'create table IF NOT EXISTS product(productId TEXT PRIMARY KEY, productName TEXT, price INTEGER, quantity INTEGER)');
  }, version: 1);
  return database;
}

class ProductService {
  Database db;

  ProductService(this.db);

  Future<void> insert(Product p) async {
    db.insert("product", p.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> update(Product p) async {
    db.update("product", p.toMap(),
        where: "productId=?", whereArgs: [p.productId]);
  }

  Future<List<Product>> getAll() async {
    final List<Map<String, Object?>> products = await db.query("product");
    return [
      for (final {
            'productId': id as String,
            'productName': name as String,
            'price': price as int,
            'quantity': quantity as int
          } in products)
        Product(id, name, price, quantity),
    ];
  }

  Future<List<Product>> search(String name) async {
    final List<Map<String, Object?>> products = await db
        .query("product", where: "productName like ?", whereArgs: ["%$name%"]);
    return [
      for (final {
            'productId': id as String,
            'productName': name as String,
            'price': price as int,
            'quantity': quantity as int
          } in products)
        Product(id, name, price, quantity),
    ];
  }

  Future<Product> getById(String id) async {
    final List<Map<String, Object?>> products =
        await db.query("product", where: 'productId=?', whereArgs: [id]);
    return Product(
        products.first['productId'].toString(),
        products.first['productName'].toString(),
        products.first['price'] as int,
        products.first['quantity'] as int);
  }

  Future<void> delete(String id) async {
    await db.delete("product", where: "productId=?", whereArgs: [id]);
  }
}
