import 'package:aquaponics/src/features/onboarding/data/onboarding_repository.dart';
import 'package:aquaponics/src/features/onboarding/domain/onboard.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'onboarding_screen_controller.g.dart';

@riverpod
class OnboardingScreenController extends _$OnboardingScreenController {
  static const _initialState = OnboardingState(
    currentPage: 0,
    isLoading: true,
    onboardingContents: [],
    isOnboardingCompleted: false,
  );

  @override
  FutureOr<OnboardingState> build() async {
    return _initialState;
  }

  Future<void> initialize() async {
    await loadOnboardingData();
  }

  Future<void> loadOnboardingData() async {
    state = const AsyncValue.loading();
    try {
      final contents =
          await ref.read(onboardingRepositoryProvider).fetchOnboarding();

      if (contents.isEmpty) {
        throw Exception('No onboarding content available');
      }

      state = AsyncValue.data(
        _initialState.copyWith(
          isLoading: false,
          onboardingContents: contents,
        ),
      );
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> _updateState(OnboardingState newState) async {
    if (state.valueOrNull != newState) {
      state = AsyncValue.data(newState);
    }
  }

  Future<void> onSkip() async {
    final currentState = state.valueOrNull ?? _initialState;
    await _updateState(
      currentState.copyWith(
        isOnboardingCompleted: true,
      ),
    );
  }

  Future<void> onDone() async {
    final currentState = state.valueOrNull ?? _initialState;
    await _updateState(
      currentState.copyWith(
        isOnboardingCompleted: true,
      ),
    );
  }

  Future<void> onNext() async {
    final currentState = state.valueOrNull ?? _initialState;
    final nextPage = currentState.currentPage + 1;
    final maxPage = currentState.onboardingContents.length - 1;

    if (nextPage <= maxPage) {
      await _updateState(
        currentState.copyWith(
          currentPage: nextPage,
        ),
      );
    }
  }

  Future<void> onBack() async {
    final currentState = state.valueOrNull ?? _initialState;
    final prevPage = currentState.currentPage - 1;

    if (prevPage >= 0) {
      await _updateState(
        currentState.copyWith(
          currentPage: prevPage,
        ),
      );
    }
  }

  Future<void> onPageChanged(int page) async {
    final currentState = state.valueOrNull ?? _initialState;
    await _updateState(
      currentState.copyWith(
        currentPage: page,
      ),
    );
  }
}

class OnboardingState {
  final int currentPage;
  final bool isLoading;
  final List<Onboard> onboardingContents;
  final bool isOnboardingCompleted;

  const OnboardingState({
    required this.currentPage,
    required this.isLoading,
    required this.onboardingContents,
    this.isOnboardingCompleted = false,
  });

  OnboardingState copyWith({
    int? currentPage,
    bool? isLoading,
    List<Onboard>? onboardingContents,
    bool? isOnboardingCompleted,
  }) {
    return OnboardingState(
      currentPage: currentPage ?? this.currentPage,
      isLoading: isLoading ?? this.isLoading,
      onboardingContents: onboardingContents ?? this.onboardingContents,
      isOnboardingCompleted:
          isOnboardingCompleted ?? this.isOnboardingCompleted,
    );
  }
}
