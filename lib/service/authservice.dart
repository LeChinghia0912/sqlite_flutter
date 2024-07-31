import 'dart:convert';
import 'package:sqflite/sqflite.dart';

import '../model/auth.dart';

class AuthService {
  late Database db;
  AuthService(this.db);

  Future<void> insert(Auth user) async {
    try {
      await db.insert('user', user.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      // Xử lý lỗi
      print('Có lỗi khi đăng kí: $e');
      // Thêm logic xử lý lỗi phù hợp
    }
  }

  Future<Auth?> getUser(String username) async {
    try {
      List<Map<String, dynamic>> maps = await db.query(
        'user',
        where: 'userName = ?',
        whereArgs: [username],
      );

      if (maps.isNotEmpty) {
        return Auth.fromJson(maps.first);
      } else {
        return null;
      }
    } catch (e) {
      // Xử lý lỗi
      print('Error getting user: $e');
      // Thêm logic xử lý lỗi phù hợp
      return null;
    }
  }

  Future<bool> login(String username, String password) async {
    try {
      Auth? user = await getUser(username);
      if (user != null && user.password == password) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      // Xử lý lỗi
      print('Error logging in: $e');
      // Thêm logic xử lý lỗi phù hợp
      return false;
    }
  }

  Future<void> updateUser(Auth user) async {
    try {
      await db.update(
        'user',
        user.toMap(),
        where: 'userName = ?',
        whereArgs: [user.userName],
      );
    } catch (e) {
      // Xử lý lỗi
      print('Error updating user: $e');
      // Thêm logic xử lý lỗi phù hợp
    }
  }

  Future<void> deleteUser(String username) async {
    try {
      await db.delete(
        'user',
        where: 'userName = ?',
        whereArgs: [username],
      );
    } catch (e) {
      // Xử lý lỗi
      print('Error deleting user: $e');
      // Thêm logic xử lý lỗi phù hợp
    }
  }
}
