import 'package:aquaponics/src/features/control/domain/history.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'local_history_repository.g.dart';

abstract class LocalHistoryRepository {
  Future<History> fetchHistory();

  Stream<History> watchHistory();

  Future<void> setHistory(History history);
}

@Riverpod(keepAlive: true)
LocalHistoryRepository localHistoryRepository(Ref ref) {
  throw UnimplementedError();
}
