import 'package:aquaponics/src/features/onboarding/data/repositories/onboarding_repository.dart';
import 'package:aquaponics/src/features/onboarding/data/sources/onboarding_local_data_source.dart';
import 'package:aquaponics/src/features/onboarding/domain/onboarding.dart';

class SembastOnboardingRepository implements OnboardingRepository {
  final OnboardingLocalDataSource localDataSource;

  SembastOnboardingRepository(this.localDataSource);

  @override
  Future<List<Onboarding>> getOnboardingContents() async {
    final data = await localDataSource.getOnboardingData();
    return data.map((json) => Onboarding.fromJson(json)).toList();
  }
}
