import 'package:aquaponics/src/features/onboarding/data/repositories/sembast_onboarding_repository.dart';
import 'package:aquaponics/src/features/onboarding/data/sources/onboarding_local_data_source.dart';
import 'package:aquaponics/src/features/onboarding/domain/onboarding.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'onboarding_repository.g.dart';

abstract class OnboardingRepository {
  Future<List<Onboarding>> getOnboardingContents();
}

@Riverpod(keepAlive: true)
OnboardingRepository onboardingRepository(Ref ref) {
  final localDataSource = ref.watch(onboardingLocalDataSourceProvider);
  return SembastOnboardingRepository(localDataSource);
}
