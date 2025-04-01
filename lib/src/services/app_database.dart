// ignore: depend_on_referenced_packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' if (dart.library.html) 'dart:io' show join;

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sembast/sembast_io.dart'
    if (dart.library.html) 'package:sembast/sembast_web.dart';
import 'package:sembast_web/sembast_web.dart';

part 'app_database.g.dart';

class AppDatabase {
  static final AppDatabase _instance = AppDatabase._internal();
  factory AppDatabase() => _instance;
  AppDatabase._internal();

  Database? _db;

  static const String _dbFileName = 'app_database.db';

  Future<Database> get database async {
    if (_db != null) return _db!;

    _db = await _initDatabase();
    return _db!;
  }

  Future<Database> _initDatabase() async {
    if (!kIsWeb) {
      final appDocDir = await getApplicationDocumentsDirectory();
      final dbPath = join(appDocDir.path, _dbFileName);
      return await databaseFactoryIo.openDatabase(dbPath);
    } else {
      return await databaseFactoryWeb.openDatabase(_dbFileName);
    }
  }

  Future<void> close() async {
    if (_db != null) {
      await _db!.close();
      _db = null;
    }
  }

  StoreRef<String, dynamic> getStore(String storeName) {
    return StoreRef<String, dynamic>(storeName);
  }
}

@Riverpod(keepAlive: true)
Future<Database> appDatabase(Ref ref) {
  return AppDatabase().database;
}
