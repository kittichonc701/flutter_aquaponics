import 'package:aquaponics/src/constants/app_sizes.dart';
import 'package:aquaponics/src/features/monitoring/domain/my_files.dart';
import 'package:aquaponics/src/utils/responsive.dart';
import 'package:flutter/material.dart';

import 'file_info_card.dart';

class MyFiles extends StatelessWidget {
  const MyFiles({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "My Files",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            ElevatedButton.icon(
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: Sizes.p16 * 1.5,
                  vertical: Sizes.p16 / (Responsive.isMobile(context) ? 2 : 1),
                ),
              ),
              onPressed: () {},
              icon: Icon(Icons.add),
              label: Text("Add New"),
            ),
          ],
        ),
        SizedBox(height: Sizes.p16),
        Responsive(
          mobile: FileInfoCardGridView(
            crossAxisCount: size.width < 650 ? 2 : 4,
            childAspectRatio: size.width < 650 && size.width > 350 ? 1.3 : 1,
          ),
          tablet: FileInfoCardGridView(),
          desktop: FileInfoCardGridView(
            childAspectRatio: size.width < 1400 ? 1.1 : 1.4,
          ),
        ),
      ],
    );
  }
}

class FileInfoCardGridView extends StatelessWidget {
  const FileInfoCardGridView({
    super.key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  });

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: demoMyFiles.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: Sizes.p16,
        mainAxisSpacing: Sizes.p16,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) => FileInfoCard(info: demoMyFiles[index]),
    );
  }
}
