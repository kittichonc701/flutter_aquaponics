import 'package:aquaponics/src/app_bootstrap.dart';
import 'package:aquaponics/src/exceptions/async_error_logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension AppBootstrapFirebase on AppBootstrap {
  Future<ProviderContainer> createFirebaseProviderContainer({
    bool addDelay = true,
  }) async {
    return ProviderContainer(
      overrides: [],
      observers: [AsyncErrorLogger()],
    );
  }

  Future<void> setupEmulators() async {
    await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
    await FirebaseStorage.instance.useStorageEmulator('localhost', 9199);
    FirebaseFirestore.instance.settings =
        const Settings(persistenceEnabled: false);
  }
}
