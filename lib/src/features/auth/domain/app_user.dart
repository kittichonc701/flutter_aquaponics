// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

typedef UserID = String;

/// Simple class representing the user UID and email.
class AppUser {
  const AppUser({
    required this.uid,
    this.email,
    this.emailVerified = false,
    this.displayName,
    this.photoURL,
  });
  final UserID uid;
  final String? displayName;
  final String? email;
  final String? photoURL;
  final bool emailVerified;

  Future<void> sendEmailVerification() async {
    // no-op - implemented by subclasses
  }

  Future<bool> isAdmin() {
    return Future.value(false);
  }

  Future<void> forceRefreshIdToken() async {
    // no-op - implemented by subclasses
  }

  // * Here we override methods from [Object] directly rather than using
  // * [Equatable], since this class will be subclassed or implemented
  // * by other classes.
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppUser &&
        other.uid == uid &&
        other.email == email &&
        other.displayName == displayName &&
        other.photoURL == photoURL;
  }

  @override
  int get hashCode => uid.hashCode ^ email.hashCode;

  @override
  String toString() =>
      'AppUser(uid: $uid, email: $email, displayName: $displayName, photoURL: $photoURL)';

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'displayName': displayName,
      'email': email,
      'photoURL': photoURL,
      'emailVerified': emailVerified,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      uid: map['uid'] as String,
      displayName:
          map['displayName'] != null ? map['displayName'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      photoURL: map['photoURL'] != null ? map['photoURL'] as String : null,
      emailVerified: map['emailVerified'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) =>
      AppUser.fromMap(json.decode(source) as Map<String, dynamic>);
}
