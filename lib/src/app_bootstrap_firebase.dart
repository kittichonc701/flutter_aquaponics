import 'package:aquaponics/src/app_bootstrap.dart';
import 'package:aquaponics/src/exceptions/async_error_logger.dart';
import 'package:aquaponics/src/features/control/data/local/local_history_repository.dart';
import 'package:aquaponics/src/features/control/data/local/sembast_history_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension AppBootstrapFirebase on AppBootstrap {
  Future<ProviderContainer> createFirebaseProviderContainer(
      {bool addDelay = true}) async {
    final localHistoryRepository = await SembastHistoryRepository.makeDefault();
    return ProviderContainer(
      overrides: [
        // repositories
        localHistoryRepositoryProvider
            .overrideWithValue(localHistoryRepository),
      ],
      observers: [AsyncErrorLogger()],
    );
  }

  Future<void> setupEmulators() async {
    await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
    await FirebaseStorage.instance.useStorageEmulator('localhost', 9199);
    // * When running on the emulator, disable persistence to avoid discrepancies
    // * between the emulated database and local caches. More info here:
    // * https://firebase.google.com/docs/emulator-suite/connect_firestore#instrument_your_app_to_talk_to_the_emulators
    FirebaseFirestore.instance.settings =
        const Settings(persistenceEnabled: false);
  }
}
