// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_auth_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$remoteAuthRepositoryHash() =>
    r'ebcb8f7b6e9e5f2589e2e99108c8b8641f4d6535';

/// See also [remoteAuthRepository].
@ProviderFor(remoteAuthRepository)
final remoteAuthRepositoryProvider = Provider<RemoteAuthRepository>.internal(
  remoteAuthRepository,
  name: r'remoteAuthRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$remoteAuthRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RemoteAuthRepositoryRef = ProviderRef<RemoteAuthRepository>;
String _$authRepositoryHash() => r'dad4308ede4c37101fdfd0f2a9340eacacf71a10';

/// See also [authRepository].
@ProviderFor(authRepository)
final authRepositoryProvider = Provider<FirebaseAuthRepository>.internal(
  authRepository,
  name: r'authRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AuthRepositoryRef = ProviderRef<FirebaseAuthRepository>;
String _$authStateChangesHash() => r'199a9132d64e85888f728def3717a5163d8558aa';

/// See also [authStateChanges].
@ProviderFor(authStateChanges)
final authStateChangesProvider = StreamProvider<AppUser?>.internal(
  authStateChanges,
  name: r'authStateChangesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authStateChangesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AuthStateChangesRef = StreamProviderRef<AppUser?>;
String _$idTokenChangesHash() => r'dcd9db4e15cd156817a4895049e10fa214e6f818';

/// See also [idTokenChanges].
@ProviderFor(idTokenChanges)
final idTokenChangesProvider = StreamProvider<AppUser?>.internal(
  idTokenChanges,
  name: r'idTokenChangesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$idTokenChangesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IdTokenChangesRef = StreamProviderRef<AppUser?>;
String _$isCurrentUserAdminHash() =>
    r'b542c95009454e9386db32c4916bd6b9e2ba4a24';

/// See also [isCurrentUserAdmin].
@ProviderFor(isCurrentUserAdmin)
final isCurrentUserAdminProvider = AutoDisposeFutureProvider<bool>.internal(
  isCurrentUserAdmin,
  name: r'isCurrentUserAdminProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isCurrentUserAdminHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsCurrentUserAdminRef = AutoDisposeFutureProviderRef<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
