import 'package:aquaponics/src/features/auth/domain/app_user.dart';
import 'package:aquaponics/src/services/app_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sembast/sembast_io.dart';

part 'local_auth_repository.g.dart';

abstract class LocalAuthRepository {
  Future<void> cacheUser(AppUser user);
  Future<AppUser?> getCachedUser();
  Future<void> clearCache();
  Stream<AppUser?> watchUser();
}

@Riverpod(keepAlive: true)
LocalAuthRepository localAuthRepository(Ref ref) {
  throw UnimplementedError();
}

class SembastAuthRepository implements LocalAuthRepository {
  final Database _db;
  final StoreRef<String, dynamic> store;

  SembastAuthRepository(this._db) : store = AppDatabase().getStore('auth');

  @override
  Future<void> cacheUser(AppUser user) async {
    await store.record('current_user').put(_db, user.toJson());
  }

  @override
  Future<AppUser?> getCachedUser() async {
    final data = await store.record('current_user').get(_db);
    return data != null ? AppUser.fromJson(data) : null;
  }

  @override
  Stream<AppUser?> watchUser() {
    return store.record('current_user').onSnapshot(_db).map((snapshot) {
      return snapshot?.value != null ? AppUser.fromJson(snapshot!.value) : null;
    });
  }

  @override
  Future<void> clearCache() async {
    await store.record('current_user').delete(_db);
  }
}
