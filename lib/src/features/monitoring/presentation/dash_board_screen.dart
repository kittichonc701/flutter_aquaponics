import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:aquaponics/src/constants/app_sizes.dart';
import 'package:aquaponics/src/features/monitoring/presentation/components/header.dart';
import 'package:aquaponics/src/features/monitoring/presentation/components/recent_files.dart';
import 'package:aquaponics/src/features/monitoring/presentation/components/storage_details.dart';
import 'package:aquaponics/src/utils/responsive.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DashboardContents();
  }
}

class DashboardContents extends ConsumerStatefulWidget {
  const DashboardContents({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DashboardContentsState();
}

class _DashboardContentsState extends ConsumerState<DashboardContents> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(Sizes.p16),
      child: Column(
        children: [
          Header(),
          SizedBox(height: Sizes.p16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    gapH16,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        RecentFiles(),
                        RecentFiles(),
                      ],
                    ),
                    gapH16,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        RecentFiles(),
                        RecentFiles(),
                      ],
                    ),
                    if (Responsive.isMobile(context)) gapH16,
                    if (Responsive.isMobile(context)) StorageDetails(),
                  ],
                ),
              ),
              if (!Responsive.isMobile(context)) gapH16,
              if (!Responsive.isMobile(context))
                Expanded(
                  flex: 2,
                  child: StorageDetails(),
                ),
            ],
          )
        ],
      ),
    );
  }
}
