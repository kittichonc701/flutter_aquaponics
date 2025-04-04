import 'package:aquaponics/src/features/onboarding/domain/onboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'onboarding_repository.g.dart';

class OnboardingRepository {
  OnboardingRepository(this._firestore);

  final FirebaseFirestore _firestore;

  static String onboardsPath() => 'onboards';
  static String onboardPath(OnboardID id) => 'onboards/$id';

  Future<List<Onboard>> fetchOnboarding() async {
    try {
      final snapshot = await _firestore
          .collection('onboarding')
          .doc('contents')
          .collection('pages')
          .where('isActive', isEqualTo: true)
          .orderBy('order')
          .get();

      return snapshot.docs.map((doc) => Onboard.fromFirestore(doc)).toList();
    } catch (e) {
      throw Exception('Failed to fetch onboarding pages: $e');
    }
  }
}

@Riverpod()
OnboardingRepository onboardingRepository(Ref ref) {
  return OnboardingRepository(FirebaseFirestore.instance);
}
