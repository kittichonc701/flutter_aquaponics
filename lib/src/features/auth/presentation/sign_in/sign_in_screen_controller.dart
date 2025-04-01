import 'package:aquaponics/src/features/auth/application/auth_service.dart';
import 'package:aquaponics/src/features/auth/presentation/sign_in/email_password_sign_in_form_type.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_in_screen_controller.g.dart';

@riverpod
class SignInScreenController extends _$SignInScreenController {
  @override
  FutureOr<void> build() {
    // Initialize any necessary state or resources here
  }

  Future<bool> submit({
    required String email,
    required String password,
    required EmailPasswordSignInFormType formType,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => _authenticate(email, password, formType),
    );
    return state.hasError == false;
  }

  Future<void> _authenticate(
    String email,
    String password,
    EmailPasswordSignInFormType formType,
  ) {
    final authService = ref.read(authServiceProvider);
    try {
      switch (formType) {
        case EmailPasswordSignInFormType.signIn:
          return authService.signInWithEmailAndPassword(email, password);
        case EmailPasswordSignInFormType.register:
          return authService.createUserWithEmailAndPassword(email, password);
      }
    } catch (e) {
      if (e is FirebaseAuthException) {
        throw _convertFirebaseError(e);
      }
      rethrow;
    }
  }

  AuthError _convertFirebaseError(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return AuthError.invalidEmail;
      case 'user-disabled':
        return AuthError.userDisabled;
      case 'user-not-found':
      case 'wrong-password':
        return AuthError.invalidCredentials;
      case 'email-already-in-use':
        return AuthError.emailAlreadyInUse;
      case 'operation-not-allowed':
        return AuthError.operationNotAllowed;
      case 'weak-password':
        return AuthError.weakPassword;
      default:
        return AuthError.unknown;
    }
  }
}

enum AuthError {
  invalidEmail,
  userDisabled,
  invalidCredentials,
  emailAlreadyInUse,
  operationNotAllowed,
  weakPassword,
  networkError,
  unknown,
}
