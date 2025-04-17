import 'package:aquaponics/gen/assets.gen.dart';
import 'package:aquaponics/src/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (!Responsive.isDesktop(context))
          CircleAvatar(
            radius: 25,
            child: Assets.images.profilePic.image(width: 38, height: 38),
          ),
        if (!Responsive.isMobile(context))
          Text(
            'Dashboard',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        if (!Responsive.isMobile(context))
          Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.secondary,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: () {},
            icon: FaIcon(FontAwesomeIcons.bell),
            color: theme.colorScheme.onPrimary,
          ),
        ),
      ],
    );
  }
}
