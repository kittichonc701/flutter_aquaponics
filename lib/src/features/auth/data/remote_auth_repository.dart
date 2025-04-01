import 'package:aquaponics/src/features/auth/data/firebase_app_user.dart';
import 'package:aquaponics/src/features/auth/domain/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'remote_auth_repository.g.dart';

abstract class RemoteAuthRepository {
  Future<AppUser> signInWithEmailAndPassword(String email, String password);
  Future<AppUser> createUserWithEmailAndPassword(String email, String password);
  Future<void> signOut();
  Stream<AppUser?> authStateChanges();
  Stream<AppUser?> idTokenChanges();
}

@Riverpod(keepAlive: true)
RemoteAuthRepository remoteAuthRepository(Ref ref) {
  throw UnimplementedError();
}

class FirebaseAuthRepository implements RemoteAuthRepository {
  FirebaseAuthRepository(this._auth);
  final FirebaseAuth _auth;

  @override
  Future<AppUser> signInWithEmailAndPassword(
      String email, String password) async {
    final userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return FirebaseAppUser(userCredential.user!);
  }

  @override
  Future<AppUser> createUserWithEmailAndPassword(
      String email, String password) async {
    final userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return FirebaseAppUser(userCredential.user!);
  }

  @override
  Future<void> signOut() => _auth.signOut();

  @override
  Stream<AppUser?> authStateChanges() {
    return _auth.authStateChanges().map(_convertUser);
  }

  @override
  Stream<AppUser?> idTokenChanges() {
    return _auth.idTokenChanges().map(_convertUser);
  }

  AppUser? get currentUser => _convertUser(_auth.currentUser);

  AppUser? _convertUser(User? user) =>
      user != null ? FirebaseAppUser(user) : null;
}

@Riverpod(keepAlive: true)
FirebaseAuthRepository authRepository(Ref ref) {
  return FirebaseAuthRepository(FirebaseAuth.instance);
}

// * Using keepAlive since other providers need it to be an
// * [AlwaysAliveProviderListenable]
@Riverpod(keepAlive: true)
Stream<AppUser?> authStateChanges(Ref ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges();
}

@Riverpod(keepAlive: true)
Stream<AppUser?> idTokenChanges(Ref ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.idTokenChanges();
}

@riverpod
FutureOr<bool> isCurrentUserAdmin(Ref ref) {
  final user = ref.watch(idTokenChangesProvider).value;
  if (user != null) {
    return user.isAdmin();
  } else {
    return false;
  }
}
