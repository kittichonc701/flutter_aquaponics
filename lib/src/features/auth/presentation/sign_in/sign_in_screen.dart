import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignInScreenContents(),
    );
  }
}

class SignInScreenContents extends ConsumerStatefulWidget {
  const SignInScreenContents({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SignInScreenContentsState();
}

class _SignInScreenContentsState extends ConsumerState<SignInScreenContents> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
