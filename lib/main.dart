import 'package:aquaponics/src/app_bootstrap.dart';
import 'package:aquaponics/src/app_bootstrap_firebase.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // * Uncomment this if you need to sign out when switching between Firebase
  // * projects (e.g. Firebase Local emulator vs real Firebase backend)
  // turn off the # in the URLs on the web
  // usePathUrlStrategy();
  // create an app bootstrap instance
  final appBootstrap = AppBootstrap();
  // create a container configured with all the Firebase repositories
  final container = await appBootstrap.createFirebaseProviderContainer();
  // use the container above to create the root widget
  final root = appBootstrap.createRootWidget(container: container);
  // start the app
  runApp(root);
}
