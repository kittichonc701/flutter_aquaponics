import 'package:aquaponics/src/features/auth/data/local_auth_repository.dart';
import 'package:aquaponics/src/features/auth/data/remote_auth_repository.dart';
import 'package:aquaponics/src/features/auth/domain/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  AuthService({
    required RemoteAuthRepository remote,
    required LocalAuthRepository local,
  })  : _remote = remote,
        _local = local;

  final RemoteAuthRepository _remote;
  final LocalAuthRepository _local;

  Stream<AppUser?> get currentUser =>
      _remote.authStateChanges().asyncExpand((user) async* {
        if (user != null) {
          await _local.cacheUser(user);
          yield user;
        } else {
          // Fallback to local cache when not authenticated
          final cachedUser = await _local.getCachedUser();
          yield cachedUser;
        }
      });

  Future<AppUser> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final user = await _remote.signInWithEmailAndPassword(email, password);
      await _local.cacheUser(user);
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'network-request-failed') {
        final cachedUser = await _local.getCachedUser();
        if (cachedUser != null) {
          return cachedUser;
        }
      }
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _remote.signOut();
    await _local.clearCache();
  }

  Future<AppUser> createUserWithEmailAndPassword(
      String email, String password) async {
    final user = await _remote.createUserWithEmailAndPassword(email, password);
    await _local.cacheUser(user);
    return user;
  }

  Future<void> sendEmailVerification() async {
    final user = await _local.getCachedUser();
    if (user != null) {
      await user.sendEmailVerification();
    }
  }

  Future<bool> isAdmin() async {
    final user = await _local.getCachedUser();
    if (user != null) {
      return user.isAdmin();
    }
    return false;
  }

  Future<void> forceRefreshIdToken() async {
    final user = await _local.getCachedUser();
    if (user != null) {
      await user.forceRefreshIdToken();
    }
  }

  Future<void> clearCache() async {
    await _local.clearCache();
  }
}
