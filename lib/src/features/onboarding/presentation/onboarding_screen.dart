import 'package:aquaponics/src/features/onboarding/presentation/onboarding_screen_controller.dart';
import 'package:aquaponics/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(onboardingScreenControllerProvider.notifier).initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    final onboardingState = ref.watch(onboardingScreenControllerProvider);
    final onboardingController =
        ref.read(onboardingScreenControllerProvider.notifier);

    return Scaffold(
      body: onboardingState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) {
          Future.microtask(() => ref
              .read(onboardingScreenControllerProvider.notifier)
              .loadOnboardingData());
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Failed to load onboarding data'),
                ElevatedButton(
                  onPressed: () => ref
                      .read(onboardingScreenControllerProvider.notifier)
                      .loadOnboardingData(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        },
        data: (state) {
          if (state.isOnboardingCompleted) {
            Future.microtask(() {
              if (context.mounted) {
                return context.goNamed(AppRoute.signIn.name);
              }
            });
            return const SizedBox.shrink();
          }

          if (state.onboardingContents.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return IntroductionScreen(
            pages: state.onboardingContents.map((content) {
              return PageViewModel(
                title: content.title,
                body: content.body,
                image: Image.asset(
                  content.imagePath,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.error_outline, size: 100),
                ),
              );
            }).toList(),
            onDone: () => onboardingController.onDone(),
            done: const Text('Done'),
            skip: const Text('Skip'),
            next: const Icon(Icons.arrow_forward),
          );
        },
      ),
    );
  }
}
