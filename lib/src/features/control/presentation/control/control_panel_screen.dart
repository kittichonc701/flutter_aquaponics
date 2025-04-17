import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ControlPanelScreen extends ConsumerStatefulWidget {
  const ControlPanelScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ControlPanelScreenState();
}

class _ControlPanelScreenState extends ConsumerState<ControlPanelScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(),
        Text(
          'แมว',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
}
