import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'onboarding_local_data_source.g.dart';

class OnboardingLocalDataSource {
  Future<List<Map<String, dynamic>>> getOnboardingData() async {
    try {
      final jsonString =
          await rootBundle.loadString('assets/mocks/onboarding_data.json');
      final jsonData = json.decode(jsonString) as List;
      return jsonData.cast<Map<String, dynamic>>();
    } catch (e) {
      throw Exception('Failed to load onboarding data: $e');
    }
  }
}

@Riverpod(keepAlive: true)
OnboardingLocalDataSource onboardingLocalDataSource(Ref ref) {
  return OnboardingLocalDataSource();
}
