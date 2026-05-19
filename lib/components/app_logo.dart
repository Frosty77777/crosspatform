import 'package:flutter/material.dart';

import '../constants.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
    this.size = 40,
    this.circular = false,
  });

  final double size;
  final bool circular;

  @override
  Widget build(BuildContext context) {
    final image = Image.asset(
      kAppLogoAsset,
      width: size,
      height: size,
      fit: BoxFit.contain,
    );

    if (circular) {
      return ClipOval(child: image);
    }
    return image;
  }
}
