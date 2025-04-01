import 'dart:ui';

import 'package:aquaponics/src/app.dart';
import 'package:aquaponics/src/core/exceptions/error_logger.dart';
import 'package:aquaponics/src/features/auth/application/user_token_refresh_service.dart';
import 'package:aquaponics/src/core/localization/string_hardcoded.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppBootstrap {
  Widget createRootWidget({required ProviderContainer container}) {
    // * Initialize UserTokenRefreshService
    container.read(userTokenRefreshServiceProvider);

    final errorLogger = container.read(errorLoggerProvider);
    registerErrorHandlers(errorLogger);
    return UncontrolledProviderScope(
      container: container,
      child: const MyApp(),
    );
  }

  void registerErrorHandlers(ErrorLogger errorLogger) {
    // * Show some error UI if any uncaught exception happens
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
      errorLogger.logError(details.exception, details.stack);
    };
    // * Handle errors from the underlying platform/OS
    PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
      errorLogger.logError(error, stack);
      return true;
    };
    // * Show some error UI when any widget in the app fails to build
    ErrorWidget.builder = (FlutterErrorDetails details) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text('An error occurred'.hardcoded),
        ),
        body: Center(child: Text(details.toString())),
      );
    };
  }
}
