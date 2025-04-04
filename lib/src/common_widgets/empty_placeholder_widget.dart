import 'package:aquaponics/src/common_widgets/primary_button.dart';
import 'package:aquaponics/src/constants/app_sizes.dart';
import 'package:aquaponics/src/localization/string_hardcoded.dart';
import 'package:aquaponics/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EmptyPlaceholderWidget extends StatelessWidget {
  const EmptyPlaceholderWidget({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.p16),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              message,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            gapH32,
            PrimaryButton(
              onPressed: () => context.goNamed(AppRoute.dashboard.name),
              text: 'Go Home'.hardcoded,
            )
          ],
        ),
      ),
    );
  }
}
