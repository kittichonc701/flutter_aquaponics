import 'package:aquaponics/src/features/control/data/local/local_history_repository.dart';
import 'package:aquaponics/src/features/control/domain/history.dart';
import 'package:aquaponics/src/services/app_database.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast_web/sembast_web.dart';

class SembastHistoryRepository implements LocalHistoryRepository {
  SembastHistoryRepository(this.db) : store = AppDatabase().getStore('history');

  final Database db;
  final StoreRef<String, dynamic> store;

  static Future<SembastHistoryRepository> makeDefault() async {
    final db = await AppDatabase().database;
    return SembastHistoryRepository(db);
  }

  static const historyItemsKey = 'historyItems';

  @override
  Future<History> fetchHistory() async {
    final historyJson = await store.record(historyItemsKey).get(db) as String?;
    if (historyJson != null) {
      return History.fromJson(historyJson);
    } else {
      return const History();
    }
  }

  @override
  Stream<History> watchHistory() {
    final record = store.record(historyItemsKey);
    return record.onSnapshot(db).map((snapshot) {
      if (snapshot != null) {
        return History.fromJson(snapshot.value as String);
      } else {
        return const History();
      }
    });
  }

  @override
  Future<void> setHistory(History history) {
    return store.record(historyItemsKey).put(db, history.toJson());
  }
}
